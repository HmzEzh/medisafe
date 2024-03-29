import 'package:medisafe/network/repository/user/UpdateUserRepository.dart';
import 'package:medisafe/service/serviceLocator.dart';

class UpdateUserController {
  final updateUser = getIt.get<UpdateUserRepository>();

  // -------------- Methods ---------------
  Future<String> updateUserInfo(Map user) async {
    final res = await updateUser.updateUser(user);
    return res;
  }
}
