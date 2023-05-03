// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracker _$TrackerFromJson(Map<String, dynamic> json) => Tracker(
      id: json['id'] as int,
      nom: json['nom'] as String,
      dateDebut: json['dateDebut'] as String,
      dateFin: json['dateFin'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$TrackerToJson(Tracker instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'dateDebut': instance.dateDebut,
      'dateFin': instance.dateFin,
      'type': instance.type,
    };
