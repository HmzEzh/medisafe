import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Tracker.g.dart';

@JsonSerializable()
class Tracker {
  Tracker({
    required this.id ,
    required this.nom ,
    required this.dateDebut ,
    required this.dateFin ,
    required this.type ,
  });

  late int id;
  late String nom;
  late String dateDebut;
  late String dateFin;
  late String type ;

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


  static List<Tracker> trackerList = <Tracker>[];


  factory Tracker.fromJson(Map<String, dynamic> json) =>
      _$TrackerFromJson(json);

  Map<String, dynamic> toJson() => _$TrackerToJson(this);
}

