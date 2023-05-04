// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<dynamic, dynamic> json) => User(
      id: json['id'] == 0 ? 1 : json['id'] as int,
      nom: json['nom'] == null ? "default" : json['nom'] as String,
      prenom: json['prenom'] == null ? "default" : json['prenom'] as String,
      cin: json['cin'] == null ? "BHdefault" : json['cin'] as String,
      date_naissance: json['date_naissance'] == null
          ? "0000-00-00"
          : json['date_naissance'] as String,
      address: json['address'] == null
          ? "default address"
          : json['address'] as String,
      taille: json['taille'] == null ? 180 : int.parse(json['taille']) as int,
      poids: json['poids'] == null ? 80 : int.parse(json['poids']) as int,
      email:
          json['email'] == null ? "default@gmail.com" : json['email'] as String,
      password:
          json['password'] == null ? "testdefault" : json['password'] as String,
      tele: json['tele'] == null ? "+212 606-06060" : json['tele'] as String,
      blood: json['blood'] == null ? "O+" : json['blood'] as String,
      gender: json['gender'] == null ? "Male" : json['gender'] as String,
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
