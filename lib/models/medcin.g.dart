// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medcin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medcin _$MedcinFromJson(Map<String, dynamic> json) => Medcin(
      id: json['id'] as int,
      nom: json['nom'] as String,
      specialite: json['specialite'] as String,
      email: json['email'] as String,
      adress: json['adress'] as String,
      tele: json['tele'] as String,
      bureau: json['bureau'] as String,
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
