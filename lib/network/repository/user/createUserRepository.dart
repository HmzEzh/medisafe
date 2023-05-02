import 'package:dio/dio.dart';
import '../../api/user/createUserApi.dart';
import '../../dioException.dart';

class CreateUserRepository {
  final CreateUserApi createUserApi;
  CreateUserRepository(this.createUserApi);

  Future<String> createUser(String firstname, String lastname, String email, String password) async {
    try {
      final response = await createUserApi.createUserApi(firstname, lastname, email, password);
      String message = response.data["message"] as String;
      return message;
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e,e.response!.data[0]["message"]).toString();
      throw errorMessage;
    }
  }
}
