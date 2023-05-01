// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int,
    nom: json['nom'] as String,
    prenom: json['prenom'] as String,
    date_naissance: json['date_naissance'] as String,
    address: json['address'] as String,
    age: json['age'] as int,
    taille: json['taille'] as int,
    poids: json['poids'] as int,
    email: json['email'] as String,
    password: json['password'] as String,
    tele: json['tele'] as String,
    blood: json['blood'] as String,
    gender: json['gender'] as String,
    image: json['image'] as Uint8List);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'date_naissance': instance.date_naissance,
      'address': instance.address,
      'age': instance.age,
      'taille': instance.taille,
      'poids': instance.poids,
      'email': instance.email,
      'password': instance.password,
      'tele': instance.tele,
      'blood': instance.blood,
      'gender': instance.gender,
      'image': instance.image
    };
