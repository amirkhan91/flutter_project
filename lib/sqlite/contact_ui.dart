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

    // Print fetched contacts
    print('Fetched contacts: ${_contacts.map((contact) => contact.name).toList()}');
  }

  Future<void> _addContact() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isNotEmpty && phone.isNotEmpty) {
      final contact = Contact(name: name, phone: phone);

      // Print the contact being added
      print('Adding contact: Name: $name, Phone: $phone');

      await DatabaseHelper().insertContact(contact);
      _nameController.clear();
      _phoneController.clear();
      _fetchContacts();
    }
  }

  Future<void> _deleteContact(int id) async {
    print('Deleting contact with ID: $id');
    await DatabaseHelper().deleteContact(id);
    _fetchContacts();
  }

  Future<void> _updateContact(Contact contact) async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isNotEmpty && phone.isNotEmpty) {
      final updateContact = Contact(id: contact.id, name: name, phone: phone);

      // Print the updated contact
      print('Updating contact: ID: ${contact.id}, Name: $name, Phone: $phone');

      await DatabaseHelper().updateContact(updateContact);
      _nameController.clear();
      _phoneController.clear();
      _fetchContacts();
    }
  }

  // Function to show a dialog for editing the contact
  void _showEditDialog(Contact contact) {
    _nameController.text = contact.name;
    _phoneController.text = contact.phone;

    print('Editing contact: ID: ${contact.id}, Name: ${contact.name}, Phone: ${contact.phone}');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                maxLines: 1,
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                maxLines: 1,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _updateContact(contact);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List Data'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              maxLines: 1,
              keyboardType: TextInputType.phone,
            ),
          ),
          ElevatedButton(
            onPressed: _addContact,
            child: const Text('Add Contact'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditDialog(contact),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteContact(contact.id!),
                      ),
                    ],
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
