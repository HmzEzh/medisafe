import 'package:dio/dio.dart';

import '../../dioClient.dart';
import '../Endpoints.dart';

class MedicamentApi {
  final DioClient dioClient;

  MedicamentApi({required this.dioClient});
  Future<Response> createMedicamentApi(int id, String title, String dateDebut, String dateFin, String type, String category, String forme) async {
    try {

      final Response response = await dioClient.post(Endpoints.createMedicament,
          data: {
            "id": id,
            "title":title,
            "dateDebut": dateDebut,
            "dateFin": dateFin,
            "type":type,
            "category": category,
            "forme":forme,
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


  Future<Response> getAllMedicaments() async {
    try {
      final Response response = await dioClient.get(Endpoints.allMedicaments);
      return response;
    } catch (e) {
      rethrow;
    }
  }


}
