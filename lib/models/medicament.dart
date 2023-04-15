import 'package:medisafe/helpers/DatabaseHelper.dart';

class Medicament {
  Medicament({
    required this.id ,
    this.title = '',
    this.imagePath = '',
    this.nbrJour ="",
    this.type = "",
    this.category = 'assets/images/medicine.png',
  });

  int id;
  String title;
  String nbrJour;
  String type = "";
  String category="";
  String imagePath = 'assets/images/medicine.png';

  static List<Medicament> categoryList = <Medicament>[
    Medicament(
      id: 1,
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 1',
      nbrJour: "24-04-2023",
      type: "",
      category:"12:30",
    ),
    Medicament(
      id: 2,
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 2',
      nbrJour: "24-04-2023",
      type: "",
      category: "10:30",
    ),
    Medicament(
      id: 3,
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 3',
      nbrJour: "24-04-2023",
      type: "",
      category: "11:30",
    ),
  ];


  factory Medicament.fromMap(Map<String, dynamic> map) {
    return Medicament(
      id: map['id'] as int,
      title: map['nom'] as String,
      type: map['type'] as String,
      category: map['category'] as String,
      nbrJour: map['nbrDeJour'] as String,
      imagePath: 'assets/images/medicine.png',
    );
  }
  static Future<void> addCat() async {
    //
    DatabaseHelper medicamentService =DatabaseHelper.instance;

    final data = await medicamentService.getMedicaments();
    popularCourseList.clear();
    for(int i=0;i<data.length;i++){

      print("nombre dsata = ${data[i]}");
      popularCourseList.add(Medicament(
        id: data[i]['id'],
        imagePath: 'assets/images/medicine.png',
        title: data[i]['nom'],
        nbrJour: data[i]['nbrDeJour'],
        type: data[i]['type'],
        category: data[i]['category'],
      ));
      print("done");
    }
  }

  Future<void> dod(Medicament category) async {
    popularCourseList.remove(category);
  }


  static List<Medicament> popularCourseList = <Medicament>[

  ];
}
