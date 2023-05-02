import 'package:dio/dio.dart';

import '../api/TrackerApi.dart';
import '../dioException.dart';

class TrackerRepository {
  final TrackerApi trackerApi;
  TrackerRepository(this.trackerApi);

  Future<String> create(int id, String nom, String dateDebut, String dateFin, String type) async {
    try {
      final response = await trackerApi.createtrackerApi(id,  nom,  dateDebut,  dateFin,  type);
      String message = response.data["message"] as String;
      return "message";
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.response!.data[0]["message"]).toString();
      throw errorMessage;
    }
  }
}