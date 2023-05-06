import 'package:dio/dio.dart';
import 'package:medisafe/models/medcin.dart';

import '../../../models/HistoriqueDoze.dart';
import '../../dioClient.dart';
import '../Endpoints.dart';

class HistoriqueDozeApi {
  final DioClient dioClient;

  HistoriqueDozeApi({required this.dioClient});
  Future<Response> createHistoriqueDozeApi(
      HistoriqueDoze histo, int idUser) async {
    Map<String, dynamic> ht = histo.toMapEncry();
    Map<String, dynamic> user = {
      "user": {"id": idUser}
    };
    Map<String, dynamic> medicament = {
      "medicament": {"id": histo.idMedicament}
    };
    Map<String, dynamic> doze = {
      "doze": {"id": histo.idDoze}
    };
    Map<String, dynamic> mergedJson = {};
    mergedJson.addAll(ht);
    mergedJson.addAll(user);
    mergedJson.addAll(medicament);
    mergedJson.addAll(doze);
    print(mergedJson);
    try {
      final Response response =
          await dioClient.post(Endpoints.addHisto, data: mergedJson);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllHisto() async {
    try {
      final Response response = await dioClient.get(Endpoints.allHisto);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
