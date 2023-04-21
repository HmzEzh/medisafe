class HistoriqueDoze {
  late int id;
  late int idDoze;
  late int idMedicament;
  late String valeur;
  late String remarque;
  late String datePrevu;
 
  HistoriqueDoze(
      {required this.id,
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
  factory HistoriqueDoze.fromMap(Map map) {
    return HistoriqueDoze(
      id: map['id'] as int,
      idDoze: map['idDoze'] as int,
      idMedicament: map['idMedicament'] as int,
      valeur: map['valeur'] as String,
      remarque: map['remarque'] as String,
      datePrevu: map['datePrevu'] as String,
    );
  }
  
}
