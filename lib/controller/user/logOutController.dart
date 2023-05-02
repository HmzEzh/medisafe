
import '../../network/repository/user/logoutRepository.dart';
import '../../service/serviceLocator.dart';

class LogoutController {
  // --------------- Repository -------------
  final logOut = getIt.get<LogOutRepository>();
  // -------------- Methods ---------------
  Future<bool> logout(String deviceId) async {
    final res = await logOut.logout(deviceId);
    return res;
  }

  
}