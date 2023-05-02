
import 'package:dio/dio.dart';


import '../../dioClient.dart';
import '../Endpoints.dart';

class CreateUserApi {
final DioClient dioClient;

CreateUserApi({required this.dioClient});
Future<Response> createUserApi(String firstname, String lastname , String email , String password ) async {
  try {
    final Response response = await dioClient.post(Endpoints.register,
    data: {
    "nom": firstname,
    "prenom": lastname,
    "email": email,
    "password":password
      }
    );
    return response;
  } catch (e) {
    rethrow;
  }
}


}
