import 'package:medisafe/models/Doze.dart';
import 'package:medisafe/models/Tracker.dart';
import 'package:medisafe/models/medicament.dart';
import 'package:medisafe/models/Users/user.dart';
import 'package:medisafe/models/medicamentDoze.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:medisafe/service/UserServices/UserService.dart';
import '../models/RendezVous.dart';
import '../models/medcin.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static UserService userService = UserService();
  static User utili = User.init(
      nom: "DOE",
      prenom: "Jhon",
      date_naissance: "1993-07-23",
      address: "3474 Tail Ends Road",
      age: 32,
      taille: 183,
      poids: 85,
      email: "jhondoe@gmail.com",
      password: "testjhon",
      tele: "+212 615-91203",
      blood: "A+");
  static const _databaseName = "medisafe";
  static const _databaseVersion = 1;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  late Database _db;
  Future<Database> get database async {
    if (_db != null) return _db;
    // lazily instantiate the db the first time it is accessed
    _db = await init();
    return _db;
  }

  Database get db => _db;
  // this opens the database (and creates it if it doesn't exist)
  Future<Database> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate, // Call the onUpgrade method
    );
    return _db;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE medcin (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            specialite TEXT NOT NULL,
            email TEXT NOT NULL,
            adress TEXT NOT NULL,
            tele TEXT NOT NULL,
            bureau TEXT NOT NULL
          );
          ''');
    await db.execute('''
          CREATE TABLE rendezVous (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            medecinId INTEGER,
            nom TEXT NOT NULL,
            lieu TEXT NOT NULL,
            remarque TEXT NOT NULL,
            heure TEXT NOT NULL,
            FOREIGN KEY (medecinId) REFERENCES medcin (id)                  
               ON DELETE NO ACTION ON UPDATE NO ACTION
           
          );
          ''');

    await db.execute('''
          CREATE TABLE medicament (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            type TEXT NOT NULL,
            category TEXT NOT NULL,
            dateDebut TEXT NOT NULL,
            dateFin TEXT NOT NULL,
            forme TEXT NOT NULL
          );
          ''');
    await db.execute('''
          CREATE TABLE doze (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idMedicament INTEGER NOT NULL,
            heure TEXT NOT NULL,
            suspend INTEGER NOT NULL,
            FOREIGN KEY(idMedicament) REFERENCES medicament(id)
          );
          ''');
    await db.execute('''
          CREATE TABLE tracker (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            type TEXT NOT NULL,
            dateDebut TEXT NOT NULL,
            dateFin TEXT NOT NULL
          );
          ''');
    await db.execute('''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nom TEXT NOT NULL,
      prenom TEXT NOT NULL,
      date_naissance TEXT NOT NULL,
      address TEXT NOT NULL,
      age INTEGER NOT NULL,
      taille INTEGER NOT NULL,
      poids INTEGER NOT NULL,
      email TEXT NOT NULL,
      password TEXT NOT NULL,
      tele TEXT NOT NULL,
      blood TEXT NOT NULL      
    );
    ''');

    await db.execute('''
  INSERT INTO user (nom, prenom, date_naissance, address, age, taille, poids, email, password, tele, blood)
  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''', [
      utili.nom,
      utili.prenom,
      utili.date_naissance,
      utili.address,
      utili.age,
      utili.taille,
      utili.poids,
      utili.email,
      utili.password,
      utili.tele,
      utili.blood
    ]);

    print("creating tables!!!!!!!!");
  }

  // user service !!

  Future<int> insertUser(Map<String, dynamic> row) async {
    await init();
    return await _db.insert("user", row);
  }

  Future<List<Map<String, dynamic>>> getUserById(int id) async {
    await init();
    return _db.query('user', orderBy: "id", where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    await init();
    return _db.query('user', orderBy: "id");
  }

  Future<int> queryUsersCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM user');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // Rendez-Vous
  Future<List<RendezVous>> allRendezVous() async {
    await init();
    List<RendezVous> rendezVous = [];
    for (Map<String, dynamic> item in await _db.query("rendezVous")) {
      rendezVous.add(RendezVous.fromMap(item));
    }
    return rendezVous;
  }

  // medecin service !!

  Future<int> insertMedecin(Map<String, dynamic> row) async {
    await init();
    return await _db.insert("medcin", row);
  }

  Future<List<Medcin>> queryAllRowsMedecin() async {
    await init();
    List<Medcin> medcins = [];
    for (Map<String, dynamic> item in await _db.query("medcin")) {
      medcins.add(Medcin.fromMap(item));
    }

    return medcins;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM medcin');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> updateMedecin(Map<String, dynamic> row, int id) async {
    await init();
    return await _db.update(
      "medcin",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteMedecin(int id) async {
    await init();
    return await _db.delete(
      "medcin",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // -- medicament
  Future<int> insertMedicament(String name, String type, String category,
      int nbrJour, String forme) async {
    await init();
    DateTime now = DateTime.now();
    String dateDebut = "${now.day}-${now.month}-${now.year}";

    DateTime dateAfternDays = now.add(Duration(days: nbrJour));

    // Format the date as a string
    String dateFin =
        "${dateAfternDays.day}-${dateAfternDays.month}-${dateAfternDays.year}";

    final data = {
      'nom': name,
      'type': type,
      'category': category,
      'dateDebut': dateDebut,
      'dateFin': dateFin,
      'forme': forme
    };
    int id = await _db.insert("medicament", data);

    return id;
  }

  Future<List<Map<String, dynamic>>> getMedicaments() async {
    await init();
    return _db.query('medicament', orderBy: "id");
  }

  Future<List<Medicament>> getAllMedicaments() async {
    await init();
    List<Medicament> medicaments = [];
    for (Map<String, dynamic> item in await _db.query("medicament")) {
      medicaments.add(Medicament.fromMap(item));
    }
    return medicaments;
  }

  Future<List<Map<String, dynamic>>> getMedicamentById(int id) async {
    await init();
    return _db
        .query('medicament', orderBy: "id", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteMedicament(int id) async {
    await init();
    deleteDozes(id);
    return await _db.delete(
      "medicament",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateMedicament(Map<String, dynamic> row, int id) async {
    await init();
    return await _db.update(
      "medicament",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> countMedicaments() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM medicament');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> insertDoze(String heure, int id) async {
    await init();
    final data = {'idMedicament': id, 'heure': heure, 'suspend': 0};
    int id2 = await _db.insert("doze", data);
    return id2;
  }

  Future<List<Map<String, dynamic>>> getDozes() async {
    await init();
    return _db.query('doze', orderBy: "id");
  }

  Future<int> deleteDozes(int id) async {
    await init();
    return await _db.delete(
      "doze",
      where: 'idMedicament = ?',
      whereArgs: [id],
    );
  }

  Future<List<Doze>> getAllDozes() async {
    await init();
    List<Doze> dozes = [];
    for (Map<String, dynamic> item in await _db.query("doze")) {
      dozes.add(Doze.fromMap(item));
    }
    return dozes;
  }

  Future<List<MedicamentDoze>> getAllDozesByHeure(String heure) async {
    await init();
    List<MedicamentDoze> dozes = [];
    for (Map<String, dynamic> item
        in await _db.rawQuery('SELECT * FROM doze WHERE heure LIKE "$heure"')) {
      //dozes.add(Doze.fromMap(item));
      dozes.add(await getMedicamentBydozeId(Doze.fromMap(item)));
    }
    return dozes;
  }

  Future<MedicamentDoze> getMedicamentBydozeId(Doze doze) async {
    await init();
    List<MedicamentDoze> result = [];
    int? dozeId = doze.idMedicament;
    for (Map<String, dynamic> item
        in await _db.rawQuery('SELECT * FROM medicament WHERE id="$dozeId"')) {
      MedicamentDoze medicamentDoze = MedicamentDoze.fromMap(item);
      medicamentDoze.doze = doze;
      result.add(medicamentDoze);
    }

    return result[0];
  }

  Future<int> updateDoze(Map<String, dynamic> row, int id) async {
    await init();

    int a = await _db.update(
      "doze",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );

    return a;
  }

  Future<int> deleteDoze(int id) async {
    await init();
    return await _db.delete(
      "doze",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Doze>> getDozesByIdMed(int id) async {
    await init();

    List<Doze> dozes = [];
    for (Map<String, dynamic> item in await _db.query("doze",
        orderBy: "id", where: 'idMedicament = ?', whereArgs: [id])) {
      dozes.add(Doze.fromMap(item));
    }
    return dozes;
  }

  Future<List<String>> getTableNames() async {
    final result =
        await _db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    final tableNames = result.map((row) => row['name'] as String).toList();
    return tableNames;
  }

  // for Home page
  Future<Map<String, List<MedicamentDoze>>> calenderApi() async {
    Map<String, List<MedicamentDoze>> doseMap = {};
    List<Map<String, dynamic>> results =
        await db.query('doze', orderBy: 'heure');
    for (Map<String, dynamic> result in results) {
      Doze dose = Doze.fromMap(result);
      doseMap[dose.heure] = await getAllDozesByHeure(dose.heure);
    }
    return doseMap;
  }


  //Tracker

  Future<int> insertTracker(String name, String type,int nbrweeks) async {
    await init();
    DateTime now = DateTime.now();
    String dateDebut = "${now.day}-${now.month}-${now.year}";

    DateTime dateAfternWeeks = now.add(Duration(days: nbrweeks * 7));

    // Format the date as a string
    String dateFin =
        "${dateAfternWeeks.day}-${dateAfternWeeks.month}-${dateAfternWeeks.year}";

    final data = {
      'nom': name,
      'type': type,
      'dateDebut': dateDebut,
      'dateFin': dateFin,
    };
    int id = await _db.insert("tracker", data);

    return id;
  }

  Future<List<Tracker>> allTrackers() async {
    await init();
    List<Tracker> trackers = [];
    for (Map<String, dynamic> item in await _db.query("tracker")) {
      trackers.add(Tracker.fromMap(item));
    }

    return trackers;
  }
}
