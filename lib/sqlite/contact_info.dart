import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Contact {
  final int? id;
  final String name;
  final String phone;

  Contact({this.id, required this.name, required this.phone});

  // Convert a Contact into a Map (for inserting in the database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }



  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT)",
        );
      },
    );
  }

  Future<void> insertContact(Contact contact) async {
    final db = await database;
    await db.insert('contacts', contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Contact>> getContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');

    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phone: maps[i]['phone'],
      );
    });
  }

  Future<void> deleteContact(int id) async {
    final db = await database;
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateContact(Contact contact) async{
    final db = await database;
       await db.update('contacts',contact.toMap() ,where: 'id = ?', whereArgs: [contact.id]);
  }
}

//...........................

// import 'package:sqflite_sqlcipher/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class Contact {
//   final int? id;
//   final String name;
//   final String phone;

//   Contact({this.id, required this.name, required this.phone});

//   // Convert a Contact into a Map (for inserting in the database)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'phone': phone,
//     };
//   }
// }

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();

//   static Database? _database;

//   // Secure storage instance for storing and retrieving the database password
//   static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
//   static const String _dbPasswordKey = 'db_password';

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<String> _getPassword() async {
//     // Retrieve the password from secure storage or generate a new one
//     String? password = await _secureStorage.read(key: _dbPasswordKey);

//     if (password == null) {
//       password = 'your_secure_password';  // Replace this with a generated password
//       await _secureStorage.write(key: _dbPasswordKey, value: password);
//     }
//     return password;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'contacts_secure.db');
//     String password = await _getPassword();

//     // Open the encrypted database
//     return await openDatabase(
//       path,
//       password: password,  // Use the secure password
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute(
//           "CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT)",
//         );
//       },
//     );
//   }

//   Future<void> insertContact(Contact contact) async {
//     final db = await database;
//     await db.insert('contacts', contact.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<Contact>> getContacts() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('contacts');

//     return List.generate(maps.length, (i) {
//       return Contact(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//         phone: maps[i]['phone'],
//       );
//     });
//   }

//   Future<void> deleteContact(int id) async {
//     final db = await database;
//     await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<void> updateContact(Contact contact) async {
//     final db = await database;
//     await db.update('contacts', contact.toMap(),
//         where: 'id = ?', whereArgs: [contact.id]);
//   }
// }
