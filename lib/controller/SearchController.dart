
import '../../network/repository/user/createUserRepository.dart';
import '../../service/serviceLocator.dart';
import '../network/repository/Searchrepository.dart';
class SearchController {
  final search = getIt.get<SearchRepository>();

  // -------------- Methods ---------------
  Future<List> getMedsNames(String nom,int page) async {
    final res = await search.getMeds(nom, page);
    return res;
  }
}
