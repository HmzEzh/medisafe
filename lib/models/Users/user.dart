import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  late int id;
  late String nom;
  late String prenom;
  late String cin;
  late String date_naissance;
  late String address;
  late int taille;
  late int poids;
  late String email;
  late String password;
  late String tele;
  late String blood;
  late String gender;
  late Uint8List image;

  User(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.cin,
      required this.date_naissance,
      required this.address,
      required this.taille,
      required this.poids,
      required this.email,
      required this.password,
      required this.tele,
      required this.blood,
      required this.gender,
      required this.image});

  User.create(
      {required this.nom,
      required this.prenom,
      required this.cin,
      required this.date_naissance,
      required this.address,
      required this.taille,
      required this.poids,
      required this.email,
      required this.password,
      required this.tele,
      required this.blood,
      required this.gender,
      required this.image});

  User.id(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.cin,
      required this.date_naissance,
      required this.address,
      required this.taille,
      required this.poids,
      required this.email,
      required this.password,
      required this.tele,
      required this.blood,
      required this.gender});

  User.init(
      {required this.nom,
      required this.prenom,
      required this.cin,
      required this.date_naissance,
      required this.address,
      required this.taille,
      required this.poids,
      required this.email,
      required this.password,
      required this.tele,
      required this.blood,
      required this.gender});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'cin': cin,
      'date_naissance': date_naissance,
      'address': address,
      'taille': taille,
      'poids': poids,
      'email': email,
      'password': password,
      'tele': tele,
      'blood': blood,
      'gender': gender,
      'image': image
    };
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
        id: map['id'] as int,
        nom: map['nom'] as String,
        prenom: map['prenom'] as String,
        cin: map['cin'] as String,
        date_naissance: map['date_naissance'] as String,
        address: map['address'] as String,
        taille: map['taille'] as int,
        poids: map['poids'] as int,
        email: map['email'] as String,
        password: map['password'] as String,
        tele: map['tele'] as String,
        blood: map['blood'] as String,
        gender: map['gender'] as String,
        image: map['image'] as Uint8List);
  }

  factory User.fromJson(Map<dynamic, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
