import 'package:medisafe/helpers/DatabaseHelper.dart';

class Medicament {
  Medicament({
    required this.id ,
    this.title = '',
    this.imagePath = 'assets/images/medicine.png',
    this.dateDebut ="",
    this.dateFin ="",
    this.type = "",
    this.forme = "",
    this.category = '',
  });

  int id;
  String title;
  String dateDebut;
  String dateFin;
  String type = "";
  String category="";
  String forme="";
  String imagePath = 'assets/images/medicine.png';

  static List<Medicament> categoryList = <Medicament>[
    Medicament(
      id: 1,
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 1',
      dateDebut: "24-04-2023",
      dateFin: "24-04-2023",
      type: "",
      category:"12:30",
    ),

  ];


  factory Medicament.fromMap(Map<String, dynamic> map) {

    String img = "";
    if(map['forme'].toString() == "Sirops"){
      img = 'assets/images/med4.png';
    }else if(map['forme'].toString() == "Pommade"){
      img = 'assets/images/med5.png';
    }else if(map['forme'].toString() == "Comprimés"){
      img = 'assets/images/med1.png';
    }else if(map['forme'].toString() == "gouttes"){
      img = 'assets/images/med3.png';
    }else if(map['forme'].toString() == "Capsule"){
      img = 'assets/images/med6.png';
    }else{
      img = 'assets/images/med2.png';
    }

    return Medicament(
      id: map['id'] as int,
      title: map['nom'] as String,
      type: map['type'] as String,
      category: map['category'] as String,
      forme: map['forme'] as String,
      dateDebut: map['dateDebut'] as String,
      dateFin: map['dateFin'] as String,
      imagePath: img,
    );
  }
  static Future<void> addCat() async {
    //
    DatabaseHelper medicamentService =DatabaseHelper.instance;

    final data = await medicamentService.getMedicaments();
    popularCourseList.clear();
    for(int i=0;i<data.length;i++){

      //print("nombre dsata = ${data[i]}");
      popularCourseList.add(Medicament(
        id: data[i]['id'],
        imagePath: 'assets/images/medicine.png',
        title: data[i]['nom'],
        dateDebut: data[i]['dateDebut'],
        dateFin: data[i]['dateFin'],
        type: data[i]['type'],
        category: data[i]['category'],
        forme: data[i]['forme'],
      ));

    }
  }

  static Future<void> dod(Medicament category) async {
    popularCourseList.remove(category);
  }


  static List<Medicament> popularCourseList = <Medicament>[

  ];
}
