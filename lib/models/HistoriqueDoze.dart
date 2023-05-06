import 'package:json_annotation/json_annotation.dart';

import '../helpers/MyEncryptionDecryption.dart';
part 'HistoriqueDoze.g.dart';

@JsonSerializable()
class HistoriqueDoze {
  late int id;
  late int idDoze;
  late int idMedicament;
  late String valeur;
  late String remarque;
  late String datePrevu;

  HistoriqueDoze({
    required this.id,
    required this.idDoze,
    required this.idMedicament,
    required this.valeur,
    required this.remarque,
    required this.datePrevu,
  });

  Map<String, dynamic> toMap() {
    return {
      'idDoze': idDoze,
      'idMedicament': idMedicament,
      'valeur': valeur,
      'remarque': remarque,
      'datePrevu': datePrevu,
    };
  }
  Map<String, dynamic> toMapEncry() {
    return {
      "id":id,
      'idDoze': idDoze,
      'idMedicament': idMedicament,
      'valeur': valeur==""? "":MyEncryptionDecryption.encryptAES(valeur).base64,
      'remarque': remarque ==""? "":MyEncryptionDecryption.encryptAES(remarque).base64,
      'datePrevu': datePrevu ==""? "":MyEncryptionDecryption.encryptAES(datePrevu).base64,
    };
  }

  factory HistoriqueDoze.fromMap(Map map) {
    return HistoriqueDoze(
      id: map['id'] as int,
      idDoze: map['idDoze'] as int,
      idMedicament: map['idMedicament'] as int,
      valeur: map['valeur'] as String,
      remarque: map['remarque'] as String,
      datePrevu: map['datePrevu'] as String,
    );
  }
  factory HistoriqueDoze.fromJson(Map<String, dynamic> json) =>
      _$HistoriqueDozeFromJson(json);
  Map<String, dynamic> toJson() => _$HistoriqueDozeToJson(this);
}
