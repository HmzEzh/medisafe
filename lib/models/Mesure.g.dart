// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Mesure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mesure _$MesureFromJson(Map<String, dynamic> json) => Mesure(
      id: json['id'] as int,
      idTracker: json['idTracker']['id'] as int,
      value: json['value'] as String,
      date: json['date'] as String,
      heure: json['heure'] as String,
    );

Map<String, dynamic> _$MesureToJson(Mesure instance) => <String, dynamic>{
      'id': instance.id,
      'idTracker': instance.idTracker,
      'value': instance.value,
      'date': instance.date,
      'heure': instance.heure,
    };
