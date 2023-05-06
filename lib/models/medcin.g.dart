// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medcin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medcin _$MedcinFromJson(Map<String, dynamic> json) => Medcin(
      id: json['id'] as int,
      nom: json['nom']  == null ? "" : MyEncryptionDecryption.decryptAES(json['nom']) as String,
      specialite: json['specialite']  == null ? "" : MyEncryptionDecryption.decryptAES(json['specialite']) as String,
      email: json['email']  == null ? "" : MyEncryptionDecryption.decryptAES(json['email']) as String,
      adress: json['adress']  == null ? "" : MyEncryptionDecryption.decryptAES(json['adress']) as String,
      tele: json['tele']  == null ? "" : MyEncryptionDecryption.decryptAES( json['tele']) as String,
      bureau: json['bureau']  == null ? "" : MyEncryptionDecryption.decryptAES(json['bureau']) as String,
    );

Map<String, dynamic> _$MedcinToJson(Medcin instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'specialite': instance.specialite,
      'email': instance.email,
      'adress': instance.adress,
      'tele': instance.tele,
      'bureau': instance.bureau,
    };
