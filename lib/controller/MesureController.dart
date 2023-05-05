import '../../models/Mesure.dart';
import '../../network/repository/Mesure/MesureRepository.dart';
import '../../service/serviceLocator.dart';

class MesureController {
  final creatMesure = getIt.get<MesureRepository>();

  // -------------- Methods ---------------
  Future<String> createMesure(int id, int idTracker, String value, String date, String heure) async {
    final res = await creatMesure.create(id, idTracker, value, date, heure);
    return res;
  }


  Future<List<Mesure>> getAllMesures() async {
    final allMesures = await creatMesure.getAllMesures();
    return allMesures;
  }
}