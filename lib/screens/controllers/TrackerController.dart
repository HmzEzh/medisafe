

import '../../network/repositories/TrackerRepository.dart';
import '../../service/serviceLocator.dart';

class TrackerController {
  final createTracke = getIt.get<TrackerRepository>();

  // -------------- Methods ---------------
  Future<String> createTracker(int id, String nom, String dateDebut, String dateFin, String type) async {

    final res = await createTracke.create( id,  nom,  dateDebut,  dateFin,  type);
    return res;
  }
}