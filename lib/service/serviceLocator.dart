import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medisafe/controller/user/UpdateUserController.dart';
import 'package:medisafe/network/api/tracker/TrackerApi.dart';
import 'package:medisafe/network/api/user/UpdateUserApi.dart';
import 'package:medisafe/network/repository/tracker/TrackerRepository.dart';
import 'package:medisafe/network/repository/user/UpdateUserRepository.dart';
import '../controller/HistoriqueDozeController.dart';
import '../controller/MedecinController.dart';
import '../controller/MesureController.dart';
import '../controller/RendezVousController.dart';
import '../controller/TrackerController.dart';
import '../controller/SearchController.dart';
import '../controller/user/createUserController.dart';
import '../controller/user/logOutController.dart';
import '../controller/user/loginController.dart';
import '../network/api/SearchApi.dart';
import '../network/api/dose/DoseApi.dart';
import '../network/api/historiqueDoze/HistoriqueDozeApi.dart';
import '../network/api/medecin/MedecinApi.dart';
import '../network/api/medicament/MedicamentApi.dart';
import '../network/api/mesure/MesureApi.dart';
import '../network/api/rendezVous/RendezVousApi.dart';
import '../network/api/user/createUserApi.dart';
import '../network/api/user/logOutApi.dart';
import '../network/api/user/loginApi.dart';
import '../network/dioClient.dart';
import '../network/repository/Medicament/MedicamentRepository.dart';
import '../network/repository/Mesure/MesureRepository.dart';
import '../network/repository/Searchrepository.dart';
import '../network/repository/dose/DoseRepository.dart';
import '../network/repository/historiqueDoze/HistoriqueDozeRepository.dart';
import '../network/repository/medecin/MedecinRepository.dart';
import '../network/repository/rendezVous/rendezVousRepository.dart';
import '../network/repository/user/createUserRepository.dart';
import '../network/repository/user/loginRepository.dart';
import '../network/repository/user/logoutRepository.dart';
import '../controller/DoseController.dart';
import '../controller/MedicamentController.dart';

final getIt = GetIt.instance;
Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));

  // create user
  getIt.registerSingleton(CreateUserApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(CreateUserRepository(getIt<CreateUserApi>()));
  // login
  getIt.registerSingleton(LogInApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(LogInRepository(getIt.get<LogInApi>()));
  // logout
  getIt.registerSingleton(LogOutApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(LogOutRepository(getIt.get<LogOutApi>()));
  // seggestion
  getIt.registerSingleton(SearchApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(SearchRepository(getIt<SearchApi>()));
  //medecin
  getIt.registerSingleton(MedecinApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(MedecinRepository(getIt<MedecinApi>()));
  //rendez vous
  getIt.registerSingleton(RendezVousApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(RendezVousRepository(getIt<RendezVousApi>()));

  getIt.registerSingleton(TrackerApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(TrackerRepository(getIt<TrackerApi>()));
  getIt.registerSingleton(TrackerController());

  //Dose

  getIt.registerSingleton(DoseApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(DoseRepository(getIt<DoseApi>()));

  getIt.registerSingleton(DoseController());

  //Mesure

  getIt.registerSingleton(MesureApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(MesureRepository(getIt<MesureApi>()));

  getIt.registerSingleton(MesureController());

  //Medicament

  getIt.registerSingleton(MedicamentApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(MedicamentRepository(getIt<MedicamentApi>()));
  //HistoriqueDoze

  getIt.registerSingleton(HistoriqueDozeApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(HistoriqueDozeRepository(getIt<HistoriqueDozeApi>()));

  getIt.registerSingleton(MedicamentController());



  // // login
  // getIt.registerSingleton(LogInApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(LogInRepository(getIt.get<LogInApi>()));
  // // logout
  // getIt.registerSingleton(LogOutApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(LogOutRepository(getIt.get<LogOutApi>()));
  // // create user
  // getIt.registerSingleton(CreateUserApi(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(CreateUserRepository(getIt<CreateUserApi>()));

  getIt.registerSingleton(UpdateUserApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(UpdateUserRepository(getIt.get<UpdateUserApi>()));

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
  // search controller
  getIt.registerSingleton(SearchController());
  // medecin controller
  getIt.registerSingleton(MedecinController());
  // rendezVous controller
  getIt.registerSingleton(RendezVousController());
  // historiqueDoze controller
  getIt.registerSingleton(HistoriqueDozeController());


  getIt.registerSingleton(UpdateUserController());


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
