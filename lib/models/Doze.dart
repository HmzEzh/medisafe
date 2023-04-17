class Doze {
  int? id;
  late int idMedicament;
  late String heure;
  late bool suspend;

  Doze(
      {required this.id,
        required this.idMedicament,
        required this.heure,
        required this.suspend,
      });



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idMedicament': idMedicament,
      'heure': heure,
      'suspend': suspend,

    };
  }
  factory Doze.fromMap(Map<String, dynamic> map) {
    return Doze(
      id: map['id'] as int,
      idMedicament: map['idMedicament'] as int,
      heure: map['heure'] as String,
      suspend: map['suspend']==0?false:true as bool,
    );
  }
}
