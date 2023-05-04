import 'package:flutter/foundation.dart';

class Rappel extends ChangeNotifier {
  String nom="";
  String category="";
  String forme="";
  int nombre=0;
  int idTracker = 0;
  String type="";
  String motDePasse="";
  List horaires=[];

  static double youssef=0;
  
  static final Rappel _instance = Rappel._internal();

  factory Rappel() {
    return _instance;
  }

  Rappel._internal();

  void updateData(String newData) {
    nom = newData;
    notifyListeners();
  }

  void ajouterHoraire(String horaire) {
    horaires.add(horaire);
    notifyListeners();
  }

  void setNom(String n){
    nom = n;
    notifyListeners();
  }
  void setNbr(int nr){
      nombre = nr;
      notifyListeners();
  }
  void setType(String t){
    type = t;
    notifyListeners();
  }
  void setForme(String t){
    forme = t;
    notifyListeners();
  }
  void setCategory(String t){
    category = t;
    notifyListeners();
  }
  void setMotDePasse(String t){
    motDePasse = t;
    notifyListeners();
  }
  String getNom(){
    return nom;
  }
  String getType(){
    return type;
  }
  int getNombre(){
    return nombre;
  }
  String getForme(){
    return forme;
  }
  String getCategory(){
    return category;
  }
  String getMotDePasse(){
    return motDePasse;
  }

}
