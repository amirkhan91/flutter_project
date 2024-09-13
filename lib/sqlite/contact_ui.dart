import 'package:flutter/material.dart';
import 'package:test_proj/sqlite/contact_info.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    final contacts = await DatabaseHelper().getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  Future<void> _addContact() async {
    final name = _nameController.text;
    final phone = _phoneController.text;

    if (name.isNotEmpty && phone.isNotEmpty) {
      final contact = Contact(name: name, phone: phone);
      await DatabaseHelper().insertContact(contact);
      _nameController.clear();
      _phoneController.clear();
      _fetchContacts();
    }
  }

  Future<void> _deleteContact(int id) async {
    await DatabaseHelper().deleteContact(id);
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
          ),
          ElevatedButton(
            onPressed: _addContact,
            child: Text('Add Contact'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteContact(contact.id!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
