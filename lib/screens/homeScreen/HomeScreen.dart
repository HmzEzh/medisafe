import 'package:flutter/material.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    print("zozo");
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(0, 0)),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {
                  print("test");
                },
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 38, 58, 167),
                  child: const Text('HE'),
                )),
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
            height: 80,
            child: Container(
                child: Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: (ctx, index) {
                  return Column(children: [
                    Container(
                      height: 20,
                      width: size.width / 7.0,
                      child: Text(
                        names[index % 7],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: size.width / 7.0 * (1 - 4 / 10) + 4,
                      child: Container(
                        margin: EdgeInsets.only(top: 4),
                        width: size.width / 7.0,
                        child: Center(
                          child: getAgn(days[index],
                              size.width / 7.0 * (1 - 4 / 10), context),
                        ),
                      ),
                    )
                  ]);
                },
              ),
            )),
          ),
          Expanded(child: HomeScreenContent())
        ]));
  }
}

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
              child: Center(
                  child: GestureDetector(
                // onPanUpdate: (details) {
                //   if (details.delta.dx > 0)
                //     selectedDay.setSelectedDay(selectedDay.getSelectedDay() + 1);
                //   else if (details.delta.dx < 0) {
                //     selectedDay.setSelectedDay(selectedDay.getSelectedDay() - 1);

                //   }
                // },
                child: Container(
                    width: size.width,
                    height: 200,
                    color: Colors.amberAccent[400],
                    child: Text("azaza")),
              )));
        });
  }
}
