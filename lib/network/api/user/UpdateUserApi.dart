import 'package:dio/dio.dart';

import '../../dioClient.dart';
import '../Endpoints.dart';

class UpdateUserApi {
  final DioClient dioClient;

  UpdateUserApi({required this.dioClient});
  Future<Response> updateUserInformationApi(Map userInfoMap) async {
    try {
      final Response response = await dioClient.put(
        Endpoints.updateUserInfo,
        data: userInfoMap,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
