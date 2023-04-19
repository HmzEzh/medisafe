import 'package:medisafe/helpers/DatabaseHelper.dart';

import 'Doze.dart';

class MedicamentDoze {
  MedicamentDoze({
    required this.id ,
    this.title = '',
    this.imagePath = 'assets/images/medicine.png',
    this.dateDebut ="",
    this.dateFin ="",
    this.type = "",
    this.forme = "",
    this.category = '',
    required this.doze
  });

  int id;
  String title;
  String dateDebut;
  String dateFin;
  String type = "";
  String category="";
  String forme="";
  String imagePath = 'assets/images/medicine.png';
  Doze? doze;

  


  factory MedicamentDoze.fromMap(Map<String, dynamic> map) {

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

    return MedicamentDoze(
      id: map['id'] as int,
      title: map['nom'] as String,
      type: map['type'] as String,
      category: map['category'] as String,
      forme: map['forme'] as String,
      dateDebut: map['dateDebut'] as String,
      dateFin: map['dateFin'] as String,
      imagePath: img,
      doze: null
    );
  }
  
}
