import 'package:dio/dio.dart';
import '../../../models/Doze.dart';
import '../../api/dose/DoseApi.dart';
import '../../dioException.dart';

class DoseRepository {
  final DoseApi doseApi;
  DoseRepository(this.doseApi);

  Future<String> create(int id, int idMedicament, String heure, bool suspend) async {
    try {
      final response = await doseApi.createDoseApi( id, idMedicament, heure, suspend);
      String message = response.data["message"] as String;
      return "message";
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.response!.data[0]["message"]).toString();
      throw errorMessage;
    }
  }

  Future<List<Doze>> getAllDoses() async {
    try {
      final response = await doseApi.getAllDoses();
      List<Doze> allDoses =
      (response.data as List).map((e) => Doze.fromJson(e)).toList();
      return allDoses;
    } on DioError catch (e) {
      //final errorMessage = DioExceptions.fromDioError(e).toString();
      throw "errorMessage";
    }
  }
}