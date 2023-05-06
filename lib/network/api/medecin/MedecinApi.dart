import 'package:dio/dio.dart';
import 'package:medisafe/models/medcin.dart';

import '../../dioClient.dart';
import '../Endpoints.dart';

class MedecinApi {
  final DioClient dioClient;

  MedecinApi({required this.dioClient});
  Future<Response> createMedecinApi(Medcin medecin, int idUser) async {
    Map<String, dynamic> md = medecin.toMapEncrypt();
    Map<String, dynamic> user = {"user": {"id":idUser}};
    Map<String, dynamic> mergedJson = {};
    mergedJson.addAll(md);
    mergedJson.addAll(user);
    print(mergedJson);
    try {
      final Response response =
          await dioClient.post(Endpoints.createMed, data: mergedJson);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllMeds() async {
    try {
      final Response response = await dioClient.get(Endpoints.allMeds);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
