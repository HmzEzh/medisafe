import '../../models/medicament.dart';
import '../../network/repository/Medicament/MedicamentRepository.dart';
import '../../service/serviceLocator.dart';

class MedicamentController {
  final creatMedicament = getIt.get<MedicamentRepository>();

  // -------------- Methods ---------------
  Future<String> createMedicament(int id, String title, String dateDebut, String dateFin, String type, String category, String forme) async {

    final res = await creatMedicament.create(id, title, dateDebut, dateFin, type, category, forme);
    return res;
  }


  Future<List<Medicament>> getAllMedicaments() async {
    final allMedicaments = await creatMedicament.getAllMedicaments();
    return allMedicaments;
  }
}