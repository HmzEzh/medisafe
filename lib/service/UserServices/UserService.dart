import 'dart:typed_data';

import 'package:medisafe/helpers/MyEncryptionDecryption.dart';
import 'package:medisafe/models/Rappel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/Users/user.dart';

class UserService {
  late DatabaseHelper instance = DatabaseHelper.instance;

  void insertUser(User user) async {
    Database db = await instance.database;
    //db.insert("user", user.toMap());
    await db.execute('''
  INSERT INTO user (id, nom, prenom, cin, date_naissance, address, taille, poids, email, password, tele, blood, gender, image)
  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''', [
      user.id,
      user.nom,
      user.prenom,
      user.cin,
      user.date_naissance,
      user.address,
      user.taille,
      user.poids,
      user.email,
      user.password,
      user.tele,
      user.blood,
      user.gender,
      user.image
    ]);
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

  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete(
      "user",
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

  Future<void> truncateTable() async {
    final db = await instance.database;
    await db.execute('DELETE FROM user');
    //await db.execute('VACUUM'); // optional: reclaim the unused disk space
  }

  User encryptUser(User user) {
    User new_user = User(
        id: user.id,
        nom: MyEncryptionDecryption.encryptAES(user.nom).base64,
        prenom: MyEncryptionDecryption.encryptAES(user.prenom).base64,
        cin: MyEncryptionDecryption.encryptAES(user.cin).base64,
        date_naissance:
            MyEncryptionDecryption.encryptAES(user.date_naissance).base64,
        address: MyEncryptionDecryption.encryptAES(user.address).base64,
        taille: MyEncryptionDecryption.encryptAES(user.taille).base64,
        poids: MyEncryptionDecryption.encryptAES(user.poids).base64,
        email: MyEncryptionDecryption.encryptAES(user.email).base64,
        password: MyEncryptionDecryption.encryptAES(user.password).base64,
        tele: MyEncryptionDecryption.encryptAES(user.tele).base64,
        blood: MyEncryptionDecryption.encryptAES(user.blood).base64,
        gender: MyEncryptionDecryption.encryptAES(user.gender).base64,
        image: user.image);

    return new_user;
  }

  User decryptUser(User user) {
    User new_user = User(
        id: user.id,
        nom: MyEncryptionDecryption.decryptAES(user.nom),
        prenom: MyEncryptionDecryption.decryptAES(user.prenom),
        cin: user.cin == "-"
            ? user.cin
            : MyEncryptionDecryption.decryptAES(user.cin),
        date_naissance: user.date_naissance == "2020-01-01"
            ? user.date_naissance
            : MyEncryptionDecryption.decryptAES(user.date_naissance),
        address: user.address == "-"
            ? user.address
            : MyEncryptionDecryption.decryptAES(user.address),
        taille: user.taille == "0"
            ? user.taille
            : MyEncryptionDecryption.decryptAES(user.taille),
        poids: user.poids == "0"
            ? user.poids
            : MyEncryptionDecryption.decryptAES(user.poids),
        email: MyEncryptionDecryption.decryptAES(user.email),
        password: MyEncryptionDecryption.decryptAES(user.password),
        tele: user.tele == "-"
            ? user.tele
            : MyEncryptionDecryption.decryptAES(user.tele),
        blood: user.blood == "-"
            ? user.blood
            : MyEncryptionDecryption.decryptAES(user.blood),
        gender: user.gender == "-"
            ? user.gender
            : MyEncryptionDecryption.decryptAES(user.gender),
        image: user.image);

    return new_user;
  }
}
