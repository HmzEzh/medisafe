import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../dioClient.dart';
import '../Endpoints.dart';

class CreateUserApi {
  final DioClient dioClient;

  CreateUserApi({required this.dioClient});
  Future<Response> createUserApi(
      String firstname, String lastname, String email, String password) async {
    final ByteData imageData =
        await rootBundle.load('assets/images/default.png');
    final Uint8List image = imageData.buffer.asUint8List();
    try {
      final Response response = await dioClient.post(Endpoints.register, data: {
        "nom": firstname,
        "prenom": lastname,
        "email": email,
        "password": password,
        "image": image
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
