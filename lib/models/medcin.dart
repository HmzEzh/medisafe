import 'package:json_annotation/json_annotation.dart';

import '../helpers/MyEncryptionDecryption.dart';
part 'medcin.g.dart';
@JsonSerializable()
class Medcin {
  late int id;
  late String nom;
  late String specialite;
  late String email;
  late String adress;
  late String tele;
  late String bureau;
 

  Medcin(
      {required this.id,
      required this.nom,
      required this.specialite,
      required this.email,
      required this.adress,
      required this.tele,
      required this.bureau,
      });
      Medcin.az(
      {
      required this.nom,
      required this.specialite,
      required this.email,
      required this.adress,
      required this.tele,
      required this.bureau,
      });

    Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'specialite': specialite,
      'email': email,
      'adress': adress,
      'tele': tele,
      'bureau': bureau,
    };
  }
   Map<String, dynamic> toMapEncrypt() {
    return {
      "id":id,
      'nom': nom ==""? "":MyEncryptionDecryption.encryptAES(nom).base64,
      'specialite': specialite==""? "": MyEncryptionDecryption.encryptAES(specialite).base64,
      'email': email ==""? "": MyEncryptionDecryption.encryptAES(email).base64,
      'adress': adress ==""? "": MyEncryptionDecryption.encryptAES(adress).base64,
      'tele':  tele==""? "":MyEncryptionDecryption.encryptAES(tele).base64,
      'bureau': bureau ==""? "":MyEncryptionDecryption.encryptAES(bureau).base64,
    };
  }
  factory Medcin.fromMap(Map map) {
    return Medcin(
      id: map['id'] as int,
      nom: map['nom'] as String,
      specialite: map['specialite'] as String,
      email: map['email'] as String,
      adress: map['adress'] as String,
      tele: map['tele'] as String,
      bureau: map['bureau'] as String,
    );
  }
  factory Medcin.fromJson(Map<String, dynamic> json) =>
      _$MedcinFromJson(json);
  Map<String, dynamic> toJson() => _$MedcinToJson(this);
}
