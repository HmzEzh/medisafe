import 'package:json_annotation/json_annotation.dart';


part 'RendezVous.g.dart';

@JsonSerializable()
class RendezVous {
  int? id;
  late int medecinId;
  late String nom;
  late String lieu;
  late String remarque;
  late String heure;

  RendezVous({
    required this.id,
    required this.medecinId,
    required this.nom,
    required this.lieu,
    required this.remarque,
    required this.heure,
  });

  RendezVous.az({
    required this.medecinId,
    required this.nom,
    required this.lieu,
    required this.remarque,
    required this.heure,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medecinId': medecinId,
      'nom': nom,
      'lieu': lieu,
      'remarque': remarque,
      'heure': heure,
    };
  }

  factory RendezVous.fromMap(Map<String, dynamic> map) {
    return RendezVous(
      id: map['id'] as int,
      medecinId: map['medecinId'] as int,
      nom: map['nom'] as String,
      lieu: map['lieu'] as String,
      remarque: map['remarque'] as String,
      heure: map['heure'] as String,
    );
  }

// factory RendezVous.fromJson(Map<String, dynamic> json) => _$RendezVousFromJson(json);
// Map<String, dynamic> toJson() => _$RendezVousToJson(this);
}
