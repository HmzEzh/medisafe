class Raport {
  late String name;
  late String idDoze;
  late String valeur;
  late String remarque;
  late String datePrevu;

  Raport({
    required this.id,
    required this.idDoze,
    required this.idMedicament,
    required this.valeur,
    required this.remarque,
    required this.datePrevu,
  });

  Map<String, dynamic> toMap() {
    return {
      'idDoze': idDoze,
      'idMedicament': idMedicament,
      'valeur': valeur,
      'remarque': remarque,
      'datePrevu': datePrevu,
    };
  }

  factory Raport.fromMap(Map map) {
    return Raport(
      id: map['id'] as int,
      idDoze: map['idDoze'] as int,
      idMedicament: map['idMedicament'] as int,
      valeur: map['valeur'] as String,
      remarque: map['remarque'] as String,
      datePrevu: map['datePrevu'] as String,
    );
  }
}
