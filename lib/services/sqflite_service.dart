import 'package:demo_back_sms/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactSqflite {
  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), 'Contacts.db'),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE Contact(id INTEGER PRIMARY KEY,name TEXT NOT NULL,number TEXT NOT NULL);'),
        version: 1);
  }

  static Future<int> addContact(MyContact contact) async {
    final db = await _getDB();
    return await db.insert('Contact', contact.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateContact(MyContact contact) async {
    final db = await _getDB();
    return await db.update('Contact', contact.toJson(),
        where: 'id=?',
        whereArgs: [contact.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteContact(MyContact contact) async {
    final db = await _getDB();
    return await db.delete('Contact', where: 'id=?', whereArgs: [contact.id]);
  }

  static Future<List<MyContact>?> getAllContact() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> map = await db.query('Contact');
    if (map.isEmpty) {
      return null;
    }

    return List.generate(map.length, (index) => MyContact.fromJson(map[index]));
  }
}
