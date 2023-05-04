import 'package:dio/dio.dart';

import '../dioClient.dart';
import 'Endpoints.dart';


class SearchApi {
  final DioClient dioClient;
  SearchApi({required this.dioClient});
  Future<Response> getmedicaments(String nom,int page) async {
    try {
      final Response response = await dioClient.get('${Endpoints.seggest}/nom=$nom&page=$page',
         );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
