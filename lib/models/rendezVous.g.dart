// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package:medisafe/models/RendezVous.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************




RendezVous _$RendezVousFromJson(Map<String, dynamic> json) => RendezVous(
      id: json['id'] as int,
      medecinId: json['medecinId'] as int,
      nom: json['nom'] as String,
      lieu: json['lieu'] as String,
      remarque: json['remarque'] as String,
      heure: json['heure'] as String,
    );

Map<String, dynamic> _$RendezVousToJson(RendezVous instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medecinId': instance.medecinId,
      'nom': instance.nom,
      'lieu': instance.lieu,
      'remarque': instance.remarque,
      'heure': instance.heure,
    };
