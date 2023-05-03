import 'package:dio/dio.dart';

import '../../../models/Mesure.dart';
import '../../api/mesure/MesureApi.dart';
import '../../dioException.dart';

class MesureRepository {
  final MesureApi mesureApi;
  MesureRepository(this.mesureApi);

  Future<String> create(int id, int idTracker, String value, String date, String heure) async {
    try {
      final response = await mesureApi.createMesureApi(id, idTracker, value, date, heure);
      String message = response.data["message"] as String;
      return "message";
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.response!.data[0]["message"]).toString();
      throw errorMessage;
    }
  }

  Future<List<Mesure>> getAllMesures() async {
    try {
      final response = await mesureApi.getAllMesures();
      List<Mesure> allMesures =
      (response.data as List).map((e) => Mesure.fromJson(e)).toList();
      return allMesures;
    } on DioError catch (e) {
      //final errorMessage = DioExceptions.fromDioError(e).toString();
      throw "errorMessage";
    }
  }
}