import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../service/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int numberOfDaysInMonth;

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
                    Noti.showBigTextNotification(id:10,title: "New message title", body: "Your long body", fln: flutterLocalNotificationsPlugin);
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
                  onPressed: () {
                    print("test");
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
                                DateFormat('EEEE').format(new DateTime(selectedDay.getSelectedYear(),selectedDay.getSelectedMonth(),index+1)).substring(0,3),
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
List<String> names = ["lun", "mar", "mer", "jeu", "ven", "sam", "dim"];

List<int> days = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("azaz");
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
    return AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return Transform(
              transform:
                  selectedDay.getOldSelectedDay() > selectedDay.getSelectedDay()
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
                  itemCount: meds.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 246, 246, 246),
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
                      margin: EdgeInsets.only(bottom: 20, left: 24, right: 24),
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
                              child: Text("8 PM",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 16, right: 16, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //color: Colors.black,
                                  margin: EdgeInsets.only(right: 16),
                                  child: Image.asset(meds[index], scale: 3),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        //color: Colors.blue,
                                        margin: EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          "med name",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Container(
                                        //color: Colors.red,
                                        child: Text("med discription")),
                                    // Container(
                                    //   color: Colors.green,
                                    //   child: Text("med etat"))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(
                            indent: 64,
                            thickness: 0.5,
                            color: Colors.black,
                            endIndent: 24,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 16, right: 16, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //color: Colors.black,
                                  margin: EdgeInsets.only(right: 16),
                                  child: Image.asset(meds[index], scale: 3),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        //color: Colors.blue,
                                        margin: EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          "med name",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Container(
                                        //color: Colors.red,
                                        child: Text("med discription")),
                                    // Container(
                                    //   color: Colors.green,
                                    //   child: Text("med etat"))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ));
        });
  }
}
// Container(
//                   decoration: BoxDecoration(
//                    color: Color.fromARGB(255, 175, 139, 21),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                     width: size.width,
//                     height: 100,
//                     margin: EdgeInsets.only(left: 16,right: 16,bottom: 8),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 21, 49, 175),
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(8),
//                               topLeft: Radius.circular(8)
//                             )
//                           ),
//                           height: 50,
//                           child: Center(
//                             child: Text("8 PM",
//                              style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                               fontWeight: FontWeight.w500)),
//                           ),),
//                           Container( 
//                              margin: EdgeInsets.only(left: 16,right: 16,bottom: 8),
//                              child: Row(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                   Image.asset(
//                                       'assets/images/med1.png',
//                                       scale: 2.5
                                    
//                                   ),
//                                   Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text("med name"),
//                                       Text("Lorem ipsum"),
//                                       Text("Lorem ipsum")
//                                     ],
//                                   )
                                
//                               ],
//                              ),
//                           )
//                       ],
//                     ))