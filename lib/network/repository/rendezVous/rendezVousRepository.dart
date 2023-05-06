import 'package:dio/dio.dart';
import '../../../models/RendezVous.dart';
import '../../api/rendezVous/RendezVousApi.dart';
import '../../dioException.dart';

class RendezVousRepository {
  final RendezVousApi rendezVousApi;
  RendezVousRepository(this.rendezVousApi);

  Future createRdv(Rendezvous rdv , int id) async {
    try {
      final response = await rendezVousApi.createRendzeVousApi(rdv,id);
     
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.toString()).toString();
      throw errorMessage;
    }
  }

  Future<List<Rendezvous>> getAllRdvs() async {
    try {
      final response = await rendezVousApi.getAllRdv();
      List<Rendezvous> allRdv =
      (response.data as List).map((e) => Rendezvous.fromMapDecrypt(e)).toList();
      return allRdv;
    } on DioError catch (e) {
      //final errorMessage = DioExceptions.fromDioError(e).toString();
      throw "errorMessage";
    }
  }
}