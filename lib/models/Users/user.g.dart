// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<dynamic, dynamic> json) => User(
      id: json['id'] == 0 ? 1 : json['id'] as int,
      nom: json['nom'] == null ? "default" : json['nom'] as String,
      prenom: json['prenom'] == null ? "default" : json['prenom'] as String,
      cin: json['cin'] == null ? "" : json['cin'] as String,
      date_naissance: json['date_naissance'] == null
          ? "2023-05-05"
          : json['date_naissance'] as String,
      address: json['address'] == null ? "" : json['address'] as String,
      taille: json['taille'] == null ? "0" : json['taille'] as String,
      poids: json['poids'] == null ? "0" : json['poids'] as String,
      email: json['email'] == null ? "" : json['email'] as String,
      password: json['password'] == null ? "" : json['password'] as String,
      tele: json['tele'] == null ? "" : json['tele'] as String,
      blood: json['blood'] == null ? "" : json['blood'] as String,
      gender: json['gender'] == null ? "" : json['gender'] as String,
      image: json['image'] == null
          ? Uint8List.fromList([72, 101, 108, 108, 111])
          : base64.decode(json['image']) as Uint8List,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'cin': instance.cin,
      'date_naissance': instance.date_naissance,
      'address': instance.address,
      'taille': instance.taille,
      'poids': instance.poids,
      'email': instance.email,
      'password': instance.password,
      'tele': instance.tele,
      'blood': instance.blood,
      'gender': instance.gender,
      'image': instance.image
    };
