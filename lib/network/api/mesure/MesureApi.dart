import 'package:dio/dio.dart';

import '../../dioClient.dart';
import '../Endpoints.dart';

class MesureApi {
  final DioClient dioClient;

  MesureApi({required this.dioClient});
  Future<Response> createMesureApi(int id, int idTracker, String value, String date, String heure) async {
    try {

      final Response response = await dioClient.post(Endpoints.createMesure,
          data: {
            "id": id,
            "value": value,
            "date": date,
            "heure":heure,
            "idTracker":{"id":idTracker},
            "user":{
              "id":1,
            }
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


  Future<Response> getAllMesures() async {
    try {
      final Response response = await dioClient.get(Endpoints.allMesures);
      return response;
    } catch (e) {
      rethrow;
    }
  }


}
