import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medisafe/network/api/TrackerApi.dart';
import 'package:medisafe/network/repositories/TrackerRepository.dart';
import 'package:medisafe/screens/controllers/TrackerController.dart';
import '../controller/user/createUserController.dart';
import '../controller/user/logOutController.dart';
import '../controller/user/loginController.dart';
import '../network/api/user/createUserApi.dart';
import '../network/api/user/logOutApi.dart';
import '../network/api/user/loginApi.dart';
import '../network/dioClient.dart';
import '../network/repository/user/createUserRepository.dart';
import '../network/repository/user/loginRepository.dart';
import '../network/repository/user/logoutRepository.dart';

final getIt = GetIt.instance;
Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));

  getIt.registerSingleton(TrackerApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(TrackerRepository(getIt<TrackerApi>()));

  getIt.registerSingleton(TrackerController());
  // // login
  // getIt.registerSingleton(LogInApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(LogInRepository(getIt.get<LogInApi>()));
  // // logout
  // getIt.registerSingleton(LogOutApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(LogOutRepository(getIt.get<LogOutApi>()));
  // // create user
  // getIt.registerSingleton(CreateUserApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(CreateUserRepository(getIt<CreateUserApi>()));
  // create user
  getIt.registerSingleton(CreateUserApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(CreateUserRepository(getIt<CreateUserApi>()));
  // login
  getIt.registerSingleton(LogInApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(LogInRepository(getIt.get<LogInApi>()));
  // logout
  getIt.registerSingleton(LogOutApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(LogOutRepository(getIt.get<LogOutApi>()));

  // //user information
  // getIt.registerSingleton(UserDetailApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(UserDetailRepository(getIt<UserDetailApi>()));
  // //update user information
  // getIt.registerSingleton(UpdateUserInformationApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(UpdateUserRepository(getIt<UpdateUserInformationApi>()));
  // //reset password
  // getIt.registerSingleton(ResetPaasswordApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(ResetPasswordRepository(getIt<ResetPaasswordApi>()));
  // //join course
  // getIt.registerSingleton(JoinCourseApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(JoinCoursRepository(getIt<JoinCourseApi>()));
  // //like course
  // getIt.registerSingleton(LikeCourseApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(LikeCoursRepository(getIt<LikeCourseApi>()));
  // //collection
  // getIt.registerSingleton(CollectionApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(CollectionRepository(getIt<CollectionApi>()));
  // //favorites/joined courses
  // getIt.registerSingleton(JoinedFavoritesCoursesApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(JoinedFavoritesCoursesRepository(getIt<JoinedFavoritesCoursesApi>()));

  //login controller
  getIt.registerSingleton(LoginController());
  // logout controller
  getIt.registerSingleton(LogoutController());
  // craete user controller
  getIt.registerSingleton(CreateUserController());


  // //user information controller
  // getIt.registerSingleton(UserDetailController());
  // //update user information controller
  // getIt.registerSingleton(UpdateUserController());
  // //reset password controller
  // getIt.registerSingleton(ResetPasswordController());
  // //join cours controller
  //  getIt.registerSingleton(JoinCourseController());
  //  //like cours controller
  //  getIt.registerSingleton(LikeCourseController());
  //  //collection controller
  //  getIt.registerSingleton(CollectionController());
  // //favorites/joined courses
  //  getIt.registerSingleton(JoinedFavoritesCoursesController());
}
