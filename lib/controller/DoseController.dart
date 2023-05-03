import '../models/Doze.dart';
import '../network/repository/dose/DoseRepository.dart';
import '../service/serviceLocator.dart';

class DoseController {
  final creatDose = getIt.get<DoseRepository>();

  // -------------- Methods ---------------
  Future<String> createDose(int id, int idMedicament, String heure, bool suspend) async {

    final res = await creatDose.create(id, idMedicament, heure, suspend);
    return res;
  }


  Future<List<Doze>> getAllDoses() async {
    final allDoses = await creatDose.getAllDoses();
    return allDoses;
  }
}