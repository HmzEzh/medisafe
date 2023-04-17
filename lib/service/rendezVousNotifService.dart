import 'package:medisafe/models/RendezVous.dart';
import '../helpers/DatabaseHelper.dart';
import '../utils/utils.dart';
import 'RendezVousService.dart';

class RendezVousNotifService {
  DatabaseHelper service =  DatabaseHelper.instance;
  Future<RendezVous?> sendNotif() async {
    List<RendezVous> rendezVous = await service.allRendezVous();
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
}
