import 'package:dio/dio.dart';

import '../../dioClient.dart';
import '../Endpoints.dart';

class DoseApi {
  final DioClient dioClient;

  DoseApi({required this.dioClient});
  Future<Response> createDoseApi(int id, int idMedicament, String heure, bool suspend ) async {
    try {
      final Response response = await dioClient.post(Endpoints.createDose,
          data: {
            "id": id,
            "idMedicament":idMedicament,
            "heure": heure,
            "suspend": suspend,
            "user":1
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


  Future<Response> getAllDoses() async {
    try {
      final Response response = await dioClient.get(Endpoints.allDoses);
      return response;
    } catch (e) {
      rethrow;
    }
  }


}
