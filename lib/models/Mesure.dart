class Mesure {
  int? id;
  late int idTracker;
  late String value;
  late String date;
  late String heure;


  Mesure(
      {required this.id,
        required this.idTracker,
        required this.value,
        required this.date,
        required this.heure,

      });



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idTracker': idTracker,
      'value': value,
      'date': date,
      'heure': heure,


    };
  }
  factory Mesure.fromMap(Map<String, dynamic> map) {
    return Mesure(
      id: map['id'] as int,
      idTracker: map['idTracker'] as int,
      value: map['value'] as String,
      date: map['date'] as String,
      heure: map['heure'] as String,
    );
  }
}
