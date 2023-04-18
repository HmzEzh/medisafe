import 'package:sqflite/sqflite.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/Users/user.dart';

class UserService {
  late DatabaseHelper instance = DatabaseHelper.instance;

  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    return await db.insert("user", user.toMap());
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

  Future<int> getUsersCount() async {
    Database db = await instance.database;
    final results = await db.rawQuery('SELECT COUNT(*) FROM user');
    return Sqflite.firstIntValue(results) ?? 0;
  }
}
