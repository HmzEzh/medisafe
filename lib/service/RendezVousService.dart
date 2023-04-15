import 'package:sqflite/sqflite.dart';
import '../models/RendezVous.dart';
import '../models/medcin.dart';
import '../helpers/DatabaseHelper.dart';

class RendezVousService {
  // medecin service !!

  late DatabaseHelper instance = DatabaseHelper.instance;

  Future<int> insertRendezVous(Map<String, dynamic> row) async {
    Database _db = await instance.database;
    return await _db.insert("rendezVous", row);
  }

  Future<List<RendezVous>> allRendezVous() async {
    Database _db = await instance.database;
    List<RendezVous> rendezVous = [];
    for (Map<String, dynamic> item in await _db.query("rendezVous")) {
      rendezVous.add(RendezVous.fromMap(item));
    }
    return rendezVous;
  }

  Future<Medcin> findMedecin(int id) async {
    Database _db = await instance.database;
    List<Map> result =
        await _db.rawQuery('SELECT * FROM medcin WHERE id = $id');
    return Medcin.fromMap(result.first);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  // Future<int> queryRowCount() async {
  //   final results = await _db.rawQuery('SELECT COUNT(*) FROM medcin');
  //   return Sqflite.firstIntValue(results) ?? 0;
  // }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> updateRendezVous(Map<String, dynamic> row, int id) async {
    Database _db = await instance.database;
    return await _db.update(
      "rendezVous",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteRendezVous(int id) async {
    Database _db = await instance.database;
    return await _db.delete(
      "rendezVous",
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
