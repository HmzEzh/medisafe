class Doze {
  int? id;
  late int idMedicament;
  late String heure;

  Doze(
      {required this.id,
        required this.idMedicament,
        required this.heure,
      });



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idMedicament': idMedicament,
      'heure': heure,
    };
  }
  factory Doze.fromMap(Map<String, dynamic> map) {
    return Doze(
      id: map['id'] as int,
      idMedicament: map['idMedicament'] as int,
      heure: map['heure'] as String,
    );
  }
}
