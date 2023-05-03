// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Doze.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doze _$DozeFromJson(Map<String, dynamic> json) => Doze(
      id: json['id'] as int?,
      idMedicament: json['idMedicament'] as int,
      heure: json['heure'] as String,
      suspend: json['suspend'] as bool,
    );

Map<String, dynamic> _$DozeToJson(Doze instance) => <String, dynamic>{
      'id': instance.id,
      'idMedicament': instance.idMedicament,
      'heure': instance.heure,
      'suspend': instance.suspend,
    };
