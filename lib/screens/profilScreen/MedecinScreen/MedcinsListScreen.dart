import 'package:flutter/material.dart';
import 'package:medisafe/screens/profilScreen/MedecinScreen/MedcinsInfosScreen.dart';

import 'AddMedcinScreen.dart';

class MedcinsListScreen extends StatefulWidget {
  const MedcinsListScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<MedcinsListScreen> createState() => _MedcinsListScreenState();
}

class _MedcinsListScreenState extends State<MedcinsListScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  IconData(0xe16a, fontFamily: 'MaterialIcons'),
                  color: Color.fromARGB(255, 38, 58, 167),
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
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => AddMedcinScreen()),
                    );
                  },
                  child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons'),color: Color.fromARGB(255, 38, 58, 167),))
            ]),
        backgroundColor: Colors.white,
        body: Container(
          //color:Color.fromARGB(255, 246, 246, 246),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (ctx, index) {
                final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController!,
                    curve: Interval((1 / 5) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                animationController?.forward();
                return AnimatedBuilder(
                    animation: animationController!,
                    builder: (BuildContext context, Widget? child) {
                      return FadeTransition(
                          opacity: animation,
                          child: Transform(
                              transform: Matrix4.translationValues(
                                  0.0, 50 * (1.0 - animation.value), 0.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                           MedcinsInfosScreen(doctorId: index,)
                                      ),
                                    );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        //color: Color.fromARGB(255, 246, 246, 246),
                                        borderRadius:
                                            const BorderRadius.all(Radius.circular(4)),
                                        // border: Border.all(
                                        //     color: DesignCourseAppTheme.nearlyBlue)
                                      ),
                                      
                                      width: size.width,
                                      height: 50,
                                      //height: 200,
                                      margin: EdgeInsets.only(
                                          top: 4, bottom: 0, left: 8, right: 8),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Spacer(flex: 1,),
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Color.fromARGB(255, 38, 58, 167),
                                              child:  Text(list[index].substring(0,2)),
                                            ),
                                            Spacer(flex: 1,),
                                            Text(list[index],style:TextStyle(
                                              fontSize: 16
                                            ),),
                                            Spacer(flex: 20,)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 2,
                                      indent: 80,
                                      endIndent: 0,
                                    )
                                  ],
                                ),
                              )));
                    });
              }),
        ));
  }
}

var list = ["doctor1", "doctor2", "doctor3", "doctor4", "doctor5"];
