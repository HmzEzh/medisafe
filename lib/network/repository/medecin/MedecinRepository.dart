import 'package:dio/dio.dart';
import '../../../models/Doze.dart';
import '../../../models/medcin.dart';
import '../../api/dose/DoseApi.dart';
import '../../api/medecin/MedecinApi.dart';
import '../../dioException.dart';

class MedecinRepository {
  final MedecinApi medecinApi;
  MedecinRepository(this.medecinApi);

  Future createMed(Medcin med , int id) async {
    try {
      final response = await medecinApi.createMedecinApi(med,id);
     
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.toString()).toString();
      throw errorMessage;
    }
  }

  Future<List<Medcin>> getAllMeds() async {
    try {
      final response = await medecinApi.getAllMeds();
      List<Medcin> allMeds =
      (response.data as List).map((e) => Medcin.fromJson(e)).toList();
      return allMeds;
    } on DioError catch (e) {
      //final errorMessage = DioExceptions.fromDioError(e).toString();
      throw "errorMessage";
    }
  }
}