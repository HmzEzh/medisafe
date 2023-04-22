import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:provider/provider.dart';
import '../../app_skoleton/appSkoleton.dart';
import '../../main.dart';
import '../../models/HistoriqueDoze.dart';
import '../../models/medicamentDoze.dart';
import '../../service/notification_service.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int numberOfDaysInMonth;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  int getTheNumberOfDaysInMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    // Add one month to get the first day of the next month
    DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
    // Subtract one day from the first day of the next month to get the last day of the current month
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    // Get the day of the month for the last day of the current month
    int numberOfDaysInMonth = lastDayOfMonth.day;
    print(numberOfDaysInMonth); // Output: 31 (for March 2023)
    return numberOfDaysInMonth;
  }

  @override
  void initState() {
    // Create a DateTime object for the first day of the month
    numberOfDaysInMonth =
        getTheNumberOfDaysInMonth(DateTime.now().year, DateTime.now().month);
    super.initState();
  }

  final ScrollController _controller = ScrollController();
  bool _init = true;
  void _animateToIndex(int index, double _width) {
    _controller.animateTo(
      (index - 1) * _width,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget getAgn(int day, double size, BuildContext context) {
    var selectedDay = Provider.of<HomeProvider>(context, listen: true);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: day == selectedDay.getSelectedDay()
            ? Color.fromARGB(255, 0, 87, 209)
            : Color.fromRGBO(255, 255, 255, 1),
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(90),
            onTap: (() {
              selectedDay.setSelectedDay(day);
            }),
            splashColor: Colors.white24,
            child: Center(
              child: Text(
                "${day}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: day == selectedDay.getSelectedDay()
                      ? Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var selectedDay = Provider.of<HomeProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
            title: Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: BorderRadius.circular(90),
                  onTap: (() {
                    Noti.showBigTextNotification(
                        id: 10,
                        title: "New message title",
                        body: "Your long body",
                        fln: flutterLocalNotificationsPlugin);
                  }),
                  splashColor: Colors.white24,
                  child: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 38, 58, 167),
                    child: Text('HE'),
                  )),
            ),
            shadowColor: Colors.transparent,
            backgroundColor: Color.fromARGB(255, 246, 246, 246),
            automaticallyImplyLeading: false,
            centerTitle: false,
            actions: [
              TextButton(
                  style: ButtonStyle(
                    // minimumSize : MaterialStateProperty.all(Size(0,0)),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () async {
                    List dozes = await databaseHelper.historiqueDoze();
                    for (var histo in dozes) {
                      print(histo.datePrevu);
                    }
                  },
                  child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons')))
            ]),
        backgroundColor: Colors.white,
        body: Column(children: [
          SizedBox(
            height: 150,
            child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 246, 246, 246),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(62, 117, 117, 117),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 12, bottom: 16),
                            child: Text("Calender",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2023, 1, 1),
                                maxTime: DateTime(2024, 12, 31),
                                onConfirm: (date) {
                              selectedDay.setSelectedDay(date.day);
                              selectedDay.setSelectedMonth(date.month);
                              selectedDay.setSelectedYear(date.year);
                              numberOfDaysInMonth = getTheNumberOfDaysInMonth(
                                  date.year, date.month);
                              _animateToIndex(date.day, size.width / 7.0);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.fr);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(
                              IconData(0xf06ae, fontFamily: 'MaterialIcons'),
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: ListView.builder(
                        controller: _controller,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: numberOfDaysInMonth,
                        itemBuilder: (ctx, index) {
                          _init
                              ? _animateToIndex(
                                  DateTime.now().day - 1, size.width / 7.0)
                              : null;
                          _init = false;
                          return Column(children: [
                            Container(
                              height: 20,
                              width: size.width / 7.0,
                              child: Text(
                                DateFormat('EEEE')
                                    .format(new DateTime(
                                        selectedDay.getSelectedYear(),
                                        selectedDay.getSelectedMonth(),
                                        index + 1))
                                    .substring(0, 3),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: size.width / 7.0 * (1 - 4 / 10) + 4,
                              child: Container(
                                margin: EdgeInsets.only(top: 4),
                                width: size.width / 7.0,
                                child: Center(
                                  child: getAgn(index + 1,
                                      size.width / 7.0 * (1 - 4 / 10), context),
                                ),
                              ),
                            )
                          ]);
                        },
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 16), child: HomeScreenContent()),
          )
        ]));
  }
}

List<String> meds = [
  "assets/images/med1.png",
  "assets/images/med2.png",
  "assets/images/med3.png",
  "assets/images/med4.png",
  "assets/images/med5.png",
  "assets/images/med6.png"
];

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
  }

  Widget body(BuildContext context, List<MedicamentDoze> medicamentDoze) {
    var selectedDay = Provider.of<HomeProvider>(context, listen: true);
    var date;
    var time;
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: medicamentDoze.length,
          itemBuilder: (ctx, index) {
            if (medicamentDoze[index].historique != null) {
              date = medicamentDoze[index].historique!.datePrevu.split(" ")[0];
              time = medicamentDoze[index].historique!.datePrevu.split(" ")[1];
            }
            return InkWell(
              onTap: () {
                if (medicamentDoze[index].historique != null) {
                  print(medicamentDoze[index].historique!.valeur);
                } else {
                  print("haaaaaaaaaaaaaaaaaaaaaaaaaa");
                }
                HistoriqueDoze historiqueDoze = HistoriqueDoze(
                    id: 0,
                    idDoze: medicamentDoze[index].doze!.id!,
                    idMedicament: medicamentDoze[index].doze!.idMedicament,
                    valeur: "",
                    remarque: "",
                    datePrevu: "");

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 50),
                          buttonPadding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          contentPadding:
                              const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
                          // title: const Text(
                          //   'La connexion a échoué',
                          //   textAlign: TextAlign.center,
                          //   style:
                          //       TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          // ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 150,
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        child: Center(
                                            child: Image.asset(
                                                medicamentDoze[index].imagePath,
                                                scale: 3))),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 8, right: 8, top: 12),
                                      child: Text(
                                        medicamentDoze[index].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 8, right: 8, top: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Icon(
                                                  IconData(0xf06ae,
                                                      fontFamily:
                                                          'MaterialIcons'),
                                                  size: 20),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 8, right: 8, top: 2),
                                              child: Text(
                                                  "Programmé pour " +
                                                      medicamentDoze[index]
                                                          .doze!
                                                          .heure +
                                                      "., " +
                                                      Utils.formatDate(
                                                          selectedDay
                                                              .getCurentdate()),
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 8, right: 8, top: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Icon(Icons.announcement,
                                                  size: 20),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 8, right: 8, top: 2),
                                              child: Text("Prendre 1 ",
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 246, 246, 246),
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                height: 80,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      onTap: () {
                                        historiqueDoze.valeur = "Non pris";
                                        historiqueDoze
                                            .datePrevu = Utils.formatDate(
                                                selectedDay.getCurentdate()) +
                                            " " +
                                            Utils.formatTime(DateTime.now());
                                        showModalBottomSheet<void>(
                                            constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                maxHeight: 9.5 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    16,
                                                minHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        3),
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(24.0),
                                                    topRight:
                                                        Radius.circular(24.0))),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 8, right: 8),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            16,
                                                        child: Center(
                                                            child: Text(
                                                          'Pouvez-vous indiquer pourquoi vous ne prenez pase cette dose ?',
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                      ),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                          onTap: () async {
                                                            historiqueDoze
                                                                    .remarque =
                                                                "Oublié / occupé / endormi";
                                                            await databaseHelper
                                                                .insertHisto(
                                                                    historiqueDoze
                                                                        .toMap());
                                                            selectedDay
                                                                .setSelectedDay(
                                                                    selectedDay
                                                                        .getSelectedDay());
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  16,
                                                              child: Center(
                                                                  child: Text(
                                                                      "Oublié / occupé / endormi",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ))))),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                          onTap: () async {
                                                            historiqueDoze
                                                                    .remarque =
                                                                "Je n'ai plus le médicament";
                                                            await databaseHelper
                                                                .insertHisto(
                                                                    historiqueDoze
                                                                        .toMap());
                                                            selectedDay
                                                                .setSelectedDay(
                                                                    selectedDay
                                                                        .getSelectedDay());
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  16,
                                                              child: Center(
                                                                  child: Text(
                                                                      "Je n'ai plus le médicament",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ))))),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                          onTap: () async {
                                                            historiqueDoze
                                                                    .remarque =
                                                                "Je n'ai pas besoin de prendre cette dose";
                                                            await databaseHelper
                                                                .insertHisto(
                                                                    historiqueDoze
                                                                        .toMap());
                                                            selectedDay
                                                                .setSelectedDay(
                                                                    selectedDay
                                                                        .getSelectedDay());
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  16,
                                                              child: Center(
                                                                  child: Text(
                                                                      "Je n'ai pas besoin de prendre cette dose",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ))))),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          historiqueDoze
                                                                  .remarque =
                                                              'Effets secondaire / autres problèmes de santé ';
                                                          await databaseHelper
                                                              .insertHisto(
                                                                  historiqueDoze
                                                                      .toMap());
                                                          selectedDay
                                                              .setSelectedDay(
                                                                  selectedDay
                                                                      .getSelectedDay());
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              16,
                                                          child: Center(
                                                              child: Text(
                                                                  'Effets secondaire / autres problèmes de santé ',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ))),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          historiqueDoze
                                                                  .remarque =
                                                              'Trop couteux';
                                                          await databaseHelper
                                                              .insertHisto(
                                                                  historiqueDoze
                                                                      .toMap());
                                                          selectedDay
                                                              .setSelectedDay(
                                                                  selectedDay
                                                                      .getSelectedDay());
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              16,
                                                          child: Center(
                                                              child: Text(
                                                                  'Trop couteux',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ))),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          historiqueDoze
                                                                  .remarque =
                                                              "Je n'ai pas le médicament à proximité";
                                                          await databaseHelper
                                                              .insertHisto(
                                                                  historiqueDoze
                                                                      .toMap());
                                                          selectedDay
                                                              .setSelectedDay(
                                                                  selectedDay
                                                                      .getSelectedDay());
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              16,
                                                          child: Center(
                                                              child: Text(
                                                                  "Je n'ai pas le médicament à proximité",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ))),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          historiqueDoze
                                                                  .remarque =
                                                              'autre';
                                                          await databaseHelper
                                                              .insertHisto(
                                                                  historiqueDoze
                                                                      .toMap());
                                                          selectedDay
                                                              .setSelectedDay(
                                                                  selectedDay
                                                                      .getSelectedDay());
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              16,
                                                          child: Center(
                                                              child: Text(
                                                                  'autre',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ))),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              16,
                                                          child: Center(
                                                              child: Text(
                                                                  'Annuler',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                            });
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.blue,
                                              size: 30,
                                            ),
                                            Text("Ignorer",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                    )),
                                    Expanded(
                                        child: InkWell(
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                      ),
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                            constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        3,
                                                minHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        3),
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(24.0),
                                                    topRight:
                                                        Radius.circular(24.0))),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            16,
                                                        child: Center(
                                                            child: Text(
                                                                'Quand avez-vous pris votre médicament?')),
                                                      ),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                          onTap: () async {
                                                            historiqueDoze
                                                                    .valeur =
                                                                "Pris";
                                                            historiqueDoze
                                                                .datePrevu = Utils
                                                                    .formatDate(
                                                                        selectedDay
                                                                            .getCurentdate()) +
                                                                " " +
                                                                Utils.formatTime(
                                                                    DateTime
                                                                        .now());
                                                            await databaseHelper
                                                                .insertHisto(
                                                                    historiqueDoze
                                                                        .toMap());
                                                            selectedDay
                                                                .setSelectedDay(
                                                                    selectedDay
                                                                        .getSelectedDay());
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  16,
                                                              child: Center(
                                                                  child: Text(
                                                                      "Maintenant",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ))))),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                          onTap: () async {
                                                            historiqueDoze
                                                                    .valeur =
                                                                "Pris";
                                                            historiqueDoze
                                                                .datePrevu = Utils
                                                                    .formatDate(
                                                                        selectedDay
                                                                            .getCurentdate()) +
                                                                " " +
                                                                medicamentDoze[
                                                                        index]
                                                                    .doze!
                                                                    .heure;
                                                            await databaseHelper
                                                                .insertHisto(
                                                                    historiqueDoze
                                                                        .toMap());
                                                            selectedDay
                                                                .setSelectedDay(
                                                                    selectedDay
                                                                        .getSelectedDay());
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  16,
                                                              child: Center(
                                                                  child: Text(
                                                                      "À temps",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ))))),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            DatePicker.showTimePicker(
                                                                context,
                                                                showTitleActions:
                                                                    true,
                                                                onConfirm:
                                                                    (date) async {
                                                              historiqueDoze
                                                                      .valeur =
                                                                  "Pris";
                                                              historiqueDoze
                                                                  .datePrevu = Utils
                                                                      .formatDate(
                                                                          selectedDay
                                                                              .getCurentdate()) +
                                                                  " " +
                                                                  Utils
                                                                      .formatTime(
                                                                          date);
                                                              await databaseHelper
                                                                  .insertHisto(
                                                                      historiqueDoze
                                                                          .toMap());
                                                              selectedDay
                                                                  .setSelectedDay(
                                                                      selectedDay
                                                                          .getSelectedDay());
                                                            },
                                                                currentTime:
                                                                    DateTime
                                                                        .now(),
                                                                locale:
                                                                    LocaleType
                                                                        .fr);
                                                          },
                                                          child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  16,
                                                              child: Center(
                                                                  child: Text(
                                                                      "Définir l'heure",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ))))),
                                                      Divider(
                                                        height: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              16,
                                                          child: Center(
                                                              child: Text(
                                                                  'Annuler',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                            });
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.done,
                                              color: Colors.blue,
                                              size: 30,
                                            ),
                                            Text("Prendre",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
              },
              child: Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 12, left: 12, right: 12),
                //margin: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 246, 246, 246),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                margin: EdgeInsets.only(left: 12, right: 12, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        //color: Colors.black,
                        margin: EdgeInsets.only(right: 16),
                        child: medicamentDoze[index].historique == null
                            ? Image.asset(medicamentDoze[index].imagePath,
                                scale: 3)
                            : medicamentDoze[index].historique!.valeur == 'Pris'
                                ? badges.Badge(
                                    position: badges.BadgePosition.topEnd(
                                        top: -10, end: -12),
                                    showBadge: true,
                                    ignorePointer: false,
                                    badgeContent: Icon(Icons.check,
                                        color: Colors.white, size: 10),
                                    badgeStyle: badges.BadgeStyle(
                                      shape: badges.BadgeShape.circle,
                                      badgeColor: Colors.green,
                                      padding: EdgeInsets.all(5),
                                    ),
                                    child: Image.asset(
                                        medicamentDoze[index].imagePath,
                                        scale: 3),
                                  )
                                : badges.Badge(
                                    position: badges.BadgePosition.topEnd(
                                        top: -10, end: -12),
                                    showBadge: true,
                                    ignorePointer: false,
                                    badgeContent: Icon(Icons.close,
                                        color: Colors.white, size: 10),
                                    badgeStyle: badges.BadgeStyle(
                                      shape: badges.BadgeShape.circle,
                                      badgeColor: Colors.red,
                                      padding: EdgeInsets.all(5),
                                    ),
                                    child: Image.asset(
                                        medicamentDoze[index].imagePath,
                                        scale: 3),
                                  )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            //color: Colors.blue,
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text(
                              medicamentDoze[index].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )),
                        Container(
                            //color: Colors.red,
                            child: Text("Prendre 1")),
                        medicamentDoze[index].historique != null
                            ? medicamentDoze[index].historique!.valeur == 'Pris'
                                ? Container(
                                    //color: Colors.red,
                                    child: Text(
                                    "Pris à $time, $date",
                                    style: TextStyle(color: Colors.green),
                                  ))
                                : SizedBox.shrink()
                            : SizedBox.shrink(),
                        medicamentDoze[index].historique != null
                            ? medicamentDoze[index].historique!.valeur ==
                                    'Non pris'
                                ? Container(
                                    //color: Colors.red,
                                    child: Text(
                                    medicamentDoze[index].historique!.remarque,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ))
                                : SizedBox.shrink()
                            : SizedBox.shrink(),
                        medicamentDoze[index].historique != null
                            ? medicamentDoze[index].historique!.valeur ==
                                    'Non pris'
                                ? Container(
                                    //color: Colors.red,
                                    child: Text(
                                    "Non pris à $time, $date",
                                    style: TextStyle(color: Colors.red),
                                  ))
                                : SizedBox.shrink()
                            : SizedBox.shrink(),

                        // Container(
                        //   color: Colors.green,
                        //   child: Text("med etat"))
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var selectedDay = Provider.of<HomeProvider>(context, listen: true);
    var size = MediaQuery.of(context).size;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation<double> animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: animationController!, curve: Curves.fastOutSlowIn),
    );
    animationController?.forward();
    return FutureBuilder<Map<String, List<MedicamentDoze>>>(
        future: databaseHelper.calenderApi(selectedDay.getCurentdate()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (ctx, index) {
                  return Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color.fromRGBO(58, 81, 96, 1)
                                          .withOpacity(0.4),
                                      offset: Offset(-4, 5),
                                      blurRadius: 4.0,
                                    ),
                                    BoxShadow(
                                      color: Color.fromARGB(0, 255, 255, 255)
                                          .withOpacity(0.4),
                                      offset: Offset(4, -5),
                                      blurRadius: 4.0,
                                    ),
                                  ]),
                              margin: EdgeInsets.only(
                                  bottom: 20, left: 24, right: 24),
                              //padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    //margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[500],
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                      ),
                                    ),
                                    height: 45,
                                    
                                  ),
                                  AppSkoleton(
                                    width: size.width ,
                                    height: 100,
                                    margin: EdgeInsets.zero,
                                    radius: BorderRadius.only(
                                     
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)))
                                ],
                              ),
                            );
                });
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text(error.toString()),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text("isEmpty"),
              );
            }
            return AnimatedBuilder(
                animation: animationController!,
                builder: (BuildContext context, Widget? child) {
                  return Transform(
                      transform: selectedDay.getOldSelectedDay() >
                              selectedDay.getSelectedDay()
                          ? Matrix4.translationValues(
                              -size.width * (1.0 - animation.value), 0.0, 0.0)
                          : Matrix4.translationValues(
                              size.width * (1.0 - animation.value), 0.0, 0.0),
                      child: GestureDetector(
                        // onPanUpdate: (details) {
                        //   if (details.delta.dx > 0)
                        //     selectedDay.setSelectedDay(selectedDay.getSelectedDay() + 1);
                        //   else if (details.delta.dx < 0) {
                        //     selectedDay.setSelectedDay(selectedDay.getSelectedDay() - 1);

                        //   }
                        // },
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color.fromRGBO(58, 81, 96, 1)
                                          .withOpacity(0.4),
                                      offset: Offset(-4, 5),
                                      blurRadius: 4.0,
                                    ),
                                    BoxShadow(
                                      color: Color.fromARGB(0, 255, 255, 255)
                                          .withOpacity(0.4),
                                      offset: Offset(4, -5),
                                      blurRadius: 4.0,
                                    ),
                                  ]),
                              margin: EdgeInsets.only(
                                  bottom: 20, left: 24, right: 24),
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 0, 87, 209),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                      ),
                                    ),
                                    height: 45,
                                    child: Center(
                                      child: Text(
                                          snapshot.data!.keys.elementAt(index),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  body(context,
                                      snapshot.data!.values.elementAt(index))
                                ],
                              ),
                            );
                          },
                        ),
                      ));
                });
          }
          return Container();
        });
  }
}
