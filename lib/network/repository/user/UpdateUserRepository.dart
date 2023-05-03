import 'package:dio/dio.dart';
import 'package:medisafe/network/api/user/UpdateUserApi.dart';
import 'package:medisafe/network/dioException.dart';

class UpdateUserRepository {
  final UpdateUserApi updateUserApi;
  UpdateUserRepository(this.updateUserApi);

  Future<String> updateUser(Map userInfoMap) async {
    try {
      final response =
          await updateUserApi.updateUserInformationApi(userInfoMap);
      String message = response.data["message"] as String;
      return "message";
    } on DioError catch (e) {
      final errorMessage =
          DioExceptions(e, e.response!.data[0]["message"]).toString();
      throw errorMessage;
    }
  }
}
