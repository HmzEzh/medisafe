import 'package:medisafe/helpers/DatabaseHelper.dart';

class Tracker {
  Tracker({
    required this.id ,
    this.nom = '',
    this.dateDebut ="",
    this.dateFin ="",
    this.type = "",
  });

  int id;
  String nom;
  String dateDebut;
  String dateFin;
  String type = "";

  static List<Tracker> categoryList = <Tracker>[
    Tracker(
      id: 1,
      dateDebut: "24-04-2023",
      dateFin: "24-04-2023",
      type: "",
      nom:"12:30",
    ),

  ];


  factory Tracker.fromMap(Map<String, dynamic> map) {

    return Tracker(
      id: map['id'] as int,
      nom: map['nom'] as String,
      type: map['type'] as String,
      dateDebut: map['dateDebut'] as String,
      dateFin: map['dateFin'] as String,
    );
  }
  static Future<void> addTracker() async {
    //
    DatabaseHelper medicamentService =DatabaseHelper.instance;

    final data = await medicamentService.getMedicaments();
    trackerList.clear();
    for(int i=0;i<data.length;i++){

      //print("nombre dsata = ${data[i]}");
      trackerList.add(Tracker(
        id: data[i]['id'],
        nom: data[i]['nom'],
        dateDebut: data[i]['dateDebut'],
        dateFin: data[i]['dateFin'],
        type: data[i]['type'],
      ));

    }
  }

  static Future<void> dod(Tracker category) async {
    trackerList.remove(category);
  }


  static List<Tracker> trackerList = <Tracker>[

  ];
}
