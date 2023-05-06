import 'package:dio/dio.dart';
import 'package:medisafe/models/medcin.dart';

import '../../../models/RendezVous.dart';
import '../../dioClient.dart';
import '../Endpoints.dart';

class RendezVousApi {
  final DioClient dioClient;

  RendezVousApi({required this.dioClient});

  Future<Response> createRendzeVousApi(
      Rendezvous rendezVous, int idUser) async {
    Map<String, dynamic> rd = rendezVous.toMapEncry();
    Map<String, dynamic> user = {
      "user": {"id": idUser}
    };
    Map<String, dynamic> medecin = {
      "medecin": {"id": rendezVous.medecinId}
    };
    Map<String, dynamic> mergedJson = {};
    mergedJson.addAll(rd);
    mergedJson.addAll(user);
    mergedJson.addAll(medecin);
    print(mergedJson);
    try {
      final Response response =
          await dioClient.post(Endpoints.createRendezvous, data: mergedJson);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllRdv() async {
    try {
      final Response response = await dioClient.get(Endpoints.allRendezvous);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
