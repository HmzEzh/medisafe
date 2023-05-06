import '../models/Doze.dart';
import '../models/medcin.dart';
import '../network/repository/dose/DoseRepository.dart';
import '../network/repository/medecin/MedecinRepository.dart';
import '../service/serviceLocator.dart';

class MedecinController {
  final medecinRepository = getIt.get<MedecinRepository>();

  // -------------- Methods ---------------
  Future createMedecin(Medcin med ,int id) async {

    final res = await medecinRepository.createMed(med,id);
    return res;
  }


  Future<List<Medcin>> getAllMeds() async {
    final allDoses = await medecinRepository.getAllMeds();
    return allDoses;
  }
}