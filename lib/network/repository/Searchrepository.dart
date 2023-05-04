import 'package:dio/dio.dart';

import '../api/SearchApi.dart';
import '../dioException.dart';

class SearchRepository {
  final SearchApi searchApi;
  SearchRepository(this.searchApi);

  Future<List> getMeds(String nom, int page) async {
    try {
      final response = await searchApi.getmedicaments(nom, page);
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.response!.data["message"]).toString();
      throw errorMessage;
    }
  }
}
