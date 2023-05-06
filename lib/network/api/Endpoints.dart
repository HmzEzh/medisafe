class Endpoints {
  Endpoints._();
  static const String baseUrl = "http://10.0.2.2:2023";
  //static const String baseUrl = "http://192.168.0.16:2023";

  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration connectionTimeout = Duration(seconds: 60);
  static const String login = "/user/login";
  static const String logout = "/user/logout";
  static const String register = "/user/register";
  static const String seggest = '/api/seggest/';
  static const String createMed = "/medecin/add";
  static const String allMeds = "/medecin/all";
  static const String createRendezvous = "/rendezVous/add";
  static const String allRendezvous = "/rendezVous/all";
    static const String addHisto = "/historiqueDoze/add";
  static const String allHisto = "/historiqueDoze/all";


  static const String category = '/category';
  static const String search = '/search';
  static const String searchParCategory = '/search/category';
  static const String searchParCours = '/search/course';
  static const String searchParChapter = '/search/chapter';



  //dialna

  static const String createTracker = "/Tracker/add";
  static const String allTrackers = "/Tracker/all";

  static const String createMesure = "/Mesure/add";
  static const String allMesures = "/Mesure/all";

  static const String createMedicament = "/Medicament/add";
  static const String allMedicaments = "/Medicament/all";

  static const String createDose = "/Dose/add";
  static const String allDoses = "/Dose/all";

  static const String updateUserInfo = "/user/update";
}
