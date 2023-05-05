import 'package:dio/dio.dart';

import '../../../models/Tracker.dart';
import '../../api/tracker/TrackerApi.dart';
import '../../dioException.dart';

class TrackerRepository {
  final TrackerApi trackerApi;
  TrackerRepository(this.trackerApi);

  Future<String> create(int id, String nom, String dateDebut, String dateFin, String type) async {
    print("g");
    try {
      final response = await trackerApi.createtrackerApi(id,  nom,  dateDebut,  dateFin,  type);
      print({id,  nom,  dateDebut,  dateFin,  type});
      String message = response.data["message"] as String;
      return "message";
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.response!.data[0]["message"]).toString();
      throw errorMessage;
    }
  }

  Future<List<Tracker>> getAllTrackers() async {
    try {

      final response = await trackerApi.getAllTrackers();
      List<Tracker> allTrackers =
      (response.data as List).map((e) => Tracker.fromJson(e)).toList();
      return allTrackers;
    } on DioError catch (e) {
      //final errorMessage = DioExceptions.fromDioError(e).toString();
      throw "errorMessage";
    }
  }
}