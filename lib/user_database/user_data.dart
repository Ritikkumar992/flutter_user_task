import 'package:sqflite/sqflite.dart';
import '../model/user.dart';
import '../database/database.dart';

class UserData {
  final dbHelper = DatabaseClass.instance;

  Future<int> insertUser(User user) async {
    Database db = await dbHelper.database;
    return await db.insert('Users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('Users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<int> updateUser(User user) async {
    Database db = await dbHelper.database;
    return await db.update('Users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('Users', where: 'id = ?', whereArgs: [id]);
  }
}
