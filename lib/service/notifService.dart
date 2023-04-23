import 'package:medisafe/models/RendezVous.dart';
import '../helpers/DatabaseHelper.dart';
import '../models/medicamentDoze.dart';
import '../utils/utils.dart';
import 'RendezVousService.dart';

class NotifService {
  DatabaseHelper db = DatabaseHelper.instance;
  Future<RendezVous?> sendRendezVousNotif() async {
    List<RendezVous> rendezVous = await db.allRendezVous();
    for (RendezVous rdv in rendezVous) {
      int rs1 = Utils.formatDate(DateTime.parse(rdv.heure))
          .compareTo(Utils.formatDate(DateTime.now()));
      if (rs1 == 0) {
        int rs2 = Utils.formatTime(DateTime.parse(rdv.heure))
            .compareTo(Utils.formatTime(DateTime.now()));
        if (rs2 == 0) {
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
