// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicament.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicament _$MedicamentFromJson(Map<String, dynamic> json) => Medicament(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      //imagePath: json['imagePath'] as String? ?? 'assets/images/medicine.png',
      dateDebut: json['dateDebut'] as String? ?? "",
      dateFin: json['dateFin'] as String? ?? "",
      type: json['type'] as String? ?? "",
      forme: json['forme'] as String? ?? "",
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$MedicamentToJson(Medicament instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'dateDebut': instance.dateDebut,
      'dateFin': instance.dateFin,
      'type': instance.type,
      'category': instance.category,
      'forme': instance.forme,
      'imagePath': instance.imagePath,
    };
