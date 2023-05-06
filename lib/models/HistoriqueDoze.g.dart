// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoriqueDoze.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoriqueDoze _$HistoriqueDozeFromJson(Map<String, dynamic> json) =>
    HistoriqueDoze(
      id: json['id'] as int,
      idDoze: json['doze']["id"] as int,
      idMedicament: json['medicament']["id"] as int,
      valeur: json['valeur'] == null ? "" : MyEncryptionDecryption.decryptAES(json['valeur']) as String,
      remarque: json['remarque'] == null ? "" : MyEncryptionDecryption.decryptAES(json['remarque']) as String,
      datePrevu: json['datePrevu'] == null ? "" : MyEncryptionDecryption.decryptAES(json['datePrevu']) as String,
    );

Map<String, dynamic> _$HistoriqueDozeToJson(HistoriqueDoze instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idDoze': instance.idDoze,
      'idMedicament': instance.idMedicament,
      'valeur': instance.valeur,
      'remarque': instance.remarque,
      'datePrevu': instance.datePrevu,
    };
