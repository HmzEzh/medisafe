import 'package:dio/dio.dart';

import 'package:platform_device_id/platform_device_id.dart';

import '../../dioClient.dart';
import '../Endpoints.dart';

class LogOutApi {
final DioClient dioClient;
LogOutApi({required this.dioClient});
Future<Response> logOutApi(String deviceId) async {
  try {
    final Response response = await dioClient.get("${Endpoints.logout}/$deviceId",
    );
    return response;
  } catch (e) {
    rethrow;
  }
}
}
