
import '../models/Doze.dart';
import '../models/RendezVous.dart';
import '../models/medcin.dart';
import '../network/repository/dose/DoseRepository.dart';
import '../network/repository/medecin/MedecinRepository.dart';
import '../network/repository/rendezVous/rendezVousRepository.dart';
import '../service/serviceLocator.dart';

class RendezVousController {
  final rendezVousRepository = getIt.get<RendezVousRepository>();

  // -------------- Methods ---------------
  Future createRendezVous(Rendezvous rdv ,int id) async {
    final res = await rendezVousRepository.createRdv(rdv,id);
    return res;
  }


  Future<List<Rendezvous>> getAllRdv() async {
    final allDoses = await rendezVousRepository.getAllRdvs();
    return allDoses;
  }
}