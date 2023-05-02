import 'package:dio/dio.dart';

import '../dioClient.dart';
import 'Endpoints.dart';

class TrackerApi {
  final DioClient dioClient;

  TrackerApi({required this.dioClient});
  Future<Response> createtrackerApi(int id, String nom, String dateDebut, String dateFin, String type) async {
    try {
      final Response response = await dioClient.post(Endpoints.createTracker,
          data: {
            "id": id,
            "nom":nom,
            "debut": dateDebut,
            "fin": dateFin,
            "type_track":type
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


}
