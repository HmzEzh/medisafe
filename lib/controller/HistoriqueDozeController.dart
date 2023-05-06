
import '../models/HistoriqueDoze.dart';
import '../network/repository/historiqueDoze/HistoriqueDozeRepository.dart';
import '../service/serviceLocator.dart';

class HistoriqueDozeController {
  final historiqueDozeRepository = getIt.get<HistoriqueDozeRepository>();

  // -------------- Methods ---------------
  Future createRendezVous(HistoriqueDoze histo ,int id) async {
    final res = await historiqueDozeRepository.createHisto(histo,id);
    return res;
  }


  Future<List<HistoriqueDoze>> getAllHisto() async {
    final allDoses = await historiqueDozeRepository.getAllHisto();
    return allDoses;
  }
}