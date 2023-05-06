import '../helpers/DatabaseHelper.dart';
import '../models/RendezVous.dart';
import '../models/medicamentDoze.dart';
import '../utils/utils.dart';

class NotifService {
  DatabaseHelper db = DatabaseHelper.instance;
  Future<Rendezvous?> sendRendezVousNotif() async {
    List<Rendezvous> rendezVous = await db.allRendezVous();
    for (Rendezvous rdv in rendezVous) {
      if (Utils.formatDate(DateTime.parse(rdv.heure)) == Utils.formatDate(DateTime.now())) {
        if (Utils.formatTime(DateTime.parse(rdv.heure)) == Utils.formatTime(DateTime.now())) {
          return rdv;
        }
      } else {
        return null;
      }
    }
    return null;
  }

  Future<String> sendmedicamentsNotif() async {
    String result = "";
    Map<String, List<MedicamentDoze>> medicaments =
        await db.calenderApi(DateTime.now());
    medicaments.forEach((key, value) {
      if (key == Utils.formatTime(DateTime.now())) {
        result = key;
      }
    });

    return result;
  }
}
