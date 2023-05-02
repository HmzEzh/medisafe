import '../../models/Users/user.dart';
import '../../network/repository/user/loginRepository.dart';
import '../../service/serviceLocator.dart';

class LoginController {
  // --------------- Repository -------------
  final loginRepository = getIt.get<LogInRepository>();
  // -------------- Methods ---------------
  Future<Map> login(String email, String password) async {
    final user = await loginRepository.getUserRequested(email, password);
    return user;
  }
}
