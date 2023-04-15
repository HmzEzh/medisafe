import 'package:medisafe/helpers/DatabaseHelper.dart';

class Category {
  Category({
    required this.id ,
    this.title = '',
    this.imagePath = '',
    this.date ="",
    this.etat = false,
    this.heure = "",
  });

  int id;
  String title;
  String date;
  bool etat = false;
  String heure="";
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      id: 1,
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 1',
      date: "24-04-2023",
      etat: true,
      heure:"12:30",
    ),
    Category(
      id: 2,
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 2',
      date: "24-04-2023",
      etat: false,
      heure: "10:30",
    ),
    Category(
      id: 3,
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 3',
      date: "24-04-2023",
      etat: false,
      heure: "11:30",
    ),
    Category(
      id: 4,
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 4',
      date: "04-05-2023",
      etat: false,
      heure: "12:30",
    ),
  ];

  Future<void> addCat() async {
    DatabaseHelper medicamentService = DatabaseHelper.instance;

    final data = await medicamentService.getMedicaments();
    popularCourseList.clear();
    for(int i=0;i<data.length;i++){
      print("nombre dsata = ${data[i]}");
      popularCourseList.add(Category(
        id: data[i]['id'],
        imagePath: 'assets/images/medicine.png',
        title: data[i]['nom'],
        date: data[i]['nbrDeJour'],
        etat: false,
        heure: data[i]['category'],
      ));
      print("done");
    }
  }

  Future<void> dod(Category category) async {
    popularCourseList.remove(category);
  }


  static List<Category> popularCourseList = <Category>[

  ];
}
