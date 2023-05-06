import 'package:json_annotation/json_annotation.dart';

import '../helpers/MyEncryptionDecryption.dart';

// part 'rendezvous.g.dart';

@JsonSerializable()
class Rendezvous {
  int? id;
  late int medecinId;
  late String nom;
  late String lieu;
  late String remarque;
  late String heure;

  Rendezvous({
    required this.id,
    required this.medecinId,
    required this.nom,
    required this.lieu,
    required this.remarque,
    required this.heure,
  });

  Rendezvous.az({
    required this.medecinId,
    required this.nom,
    required this.lieu,
    required this.remarque,
    required this.heure,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medecinId': medecinId,
      'nom': nom,
      'lieu': lieu,
      'remarque': remarque,
      'heure': heure,
    };
  }
  Map<String, dynamic> toMapEncry() {
    return {
      'id': id,
      'medecinId': medecinId,
      'nom': nom==""? "": MyEncryptionDecryption.encryptAES(nom).base64,
      'lieu':  lieu==""? "":MyEncryptionDecryption.encryptAES(lieu).base64,
      'remarque':remarque  ==""? "":MyEncryptionDecryption.encryptAES(remarque).base64,
      'heure': heure ==""? "":MyEncryptionDecryption.encryptAES(heure).base64,
    };
  }

  factory Rendezvous.fromMap(Map<String, dynamic> map) {
    return Rendezvous(
      id: map['id'] as int,
      medecinId: map['medecinId'] as int,
      nom: map['nom'] as String,
      lieu: map['lieu'] as String,
      remarque: map['remarque'] as String,
      heure: map['heure'] as String,
    );
  }
  factory Rendezvous.fromMapDecrypt(Map<String, dynamic> map) {
    return Rendezvous(
      id: map['id'] as int,
      medecinId: map['medecin']["id"] as int,
      nom: map['nom'] == null ? "" : MyEncryptionDecryption.decryptAES(map['nom']) as String,
      lieu: map['lieu']  == null ? "" : MyEncryptionDecryption.decryptAES(map['lieu']) as String,
      remarque: map['remarque']  == null ? "" : MyEncryptionDecryption.decryptAES(map['remarque']) as String,
      heure: map['heure']  == null ? "" : MyEncryptionDecryption.decryptAES(map['heure']) as String,
    );
  }

// factory Rendezvous.fromJson(Map<String, dynamic> json) =>
//       _$RendezvousFromJson(json);
//   Map<String, dynamic> toJson() => _$RendezvousToJson(this);
}
