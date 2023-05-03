import 'package:dio/dio.dart';

import '../../../models/medicament.dart';
import '../../api/medicament/MedicamentApi.dart';
import '../../dioException.dart';

class MedicamentRepository {
  final MedicamentApi medicamentApi;
  MedicamentRepository(this.medicamentApi);

  Future<String> create(int id, String title, String dateDebut, String dateFin, String type, String category, String forme) async {
    try {
      final response = await medicamentApi.createMedicamentApi(id, title, dateDebut, dateFin, type, category, forme);
      String message = response.data["message"] as String;
      return "message";
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.response!.data[0]["message"]).toString();
      throw errorMessage;
    }
  }

  Future<List<Medicament>> getAllMedicaments() async {
    try {
      final response = await medicamentApi.getAllMedicaments();
      List<Medicament> allMedicaments =
      (response.data as List).map((e) => Medicament.fromJson(e)).toList();
      return allMedicaments;
    } on DioError catch (e) {
      //final errorMessage = DioExceptions.fromDioError(e).toString();
      throw "errorMessage";
    }
  }
}