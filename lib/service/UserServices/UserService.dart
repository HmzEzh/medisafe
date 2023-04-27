import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/Users/user.dart';

class UserService {
  late DatabaseHelper instance = DatabaseHelper.instance;

  void insertUser(User user) async {
    Database db = await instance.database;
    db.insert("user", user.toMap());
  }

  Future<List<User>> getAllUsers() async {
    Database _db = await instance.database;
    List<User> users = [];
    for (Map<String, dynamic> item in await _db.query('user', orderBy: "id")) {
      users.add(User.fromMap(item));
    }
    return users;
  }

  Future<User> getUserById(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> state =
        await db.query('user', orderBy: "id", where: 'id = ?', whereArgs: [id]);
    return User.fromMap(state.first);
  }

  Future<int> updateUser(User user, int id) async {
    Database db = await instance.database;
    return await db.update(
      "user",
      user.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateUserImage(int id, List<int> imageBytes) async {
    final db = await instance.database;
    return await db.update(
      'user',
      {'image': Uint8List.fromList(imageBytes)},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getUsersCount() async {
    Database db = await instance.database;
    final results = await db.rawQuery('SELECT COUNT(*) FROM user');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<List<String>> getTableNames() async {
    Database db = await instance.database;
    final result =
        await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    final tableNames = result.map((row) => row['name'] as String).toList();
    return tableNames;
  }
}
