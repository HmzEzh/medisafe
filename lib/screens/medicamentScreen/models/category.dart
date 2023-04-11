class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.date ="",
    this.etat = false,
    this.heure = "",
  });

  String title;
  String date;
  bool etat = false;
  String heure="";
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 1',
      date: "24-04-2023",
      etat: true,
      heure:"12:30",
    ),
    Category(
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 2',
      date: "24-04-2023",
      etat: false,
      heure: "10:30",
    ),
    Category(
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 3',
      date: "24-04-2023",
      etat: false,
      heure: "11:30",
    ),
    Category(
      imagePath: 'assets/images/calendar.png',
      title: 'rendez-vous 4',
      date: "04-05-2023",
      etat: false,
      heure: "12:30",
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/images/medicine.png',
      title: 'medicament 1',
      date: "24-04-2023",
      etat: false,
      heure:"12:10",
    ),
    Category(
      imagePath: 'assets/images/medicine.png',
      title: 'medicament 2',
      date: "24-04-2023",
      etat: false,
      heure: "14:30",
    ),
    Category(
      imagePath: 'assets/images/medicine.png',
      title: 'medicament 3',
      date: "14-06-2023",
      etat: false,
      heure: "09:30",
    ),
    Category(
      imagePath: 'assets/images/medicine.png',
      title: 'medicament 4',
      date: "04-07-2023",
      etat: false,
      heure: "12:30",
    ),
  ];
}
