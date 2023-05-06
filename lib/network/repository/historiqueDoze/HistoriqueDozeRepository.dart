import 'package:dio/dio.dart';
import '../../../models/HistoriqueDoze.dart';
import '../../api/historiqueDoze/HistoriqueDozeApi.dart';
import '../../dioException.dart';

class HistoriqueDozeRepository {
  final HistoriqueDozeApi historiqueDozeApi;
  HistoriqueDozeRepository(this.historiqueDozeApi);

  Future createHisto(HistoriqueDoze histo , int id) async {
    try {
      final response = await historiqueDozeApi.createHistoriqueDozeApi( histo,id);
     
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.toString()).toString();
      throw errorMessage;
    }
  }

  Future<List<HistoriqueDoze>> getAllHisto() async {
    try {
      final response = await historiqueDozeApi.getAllHisto();
      List<HistoriqueDoze> allhisto =
      (response.data as List).map((e) => HistoriqueDoze.fromJson(e)).toList();
      return allhisto;
    } on DioError catch (e) {
      //final errorMessage = DioExceptions.fromDioError(e).toString();
      throw "errorMessage";
    }
  }
}