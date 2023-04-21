import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/medicament.dart';
import 'package:medisafe/screens/introduction_animation/introduction_animation_screen.dart';
import 'package:medisafe/screens/medicamentScreen/app_theme.dart';
import 'package:medisafe/screens/medicamentScreen/rv_list_view.dart';
import 'package:medisafe/screens/medicamentScreen/medicament_list_view.dart';
import 'package:medisafe/main.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/Tracker_list.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/add_track.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/use/list_track_shapes.dart';
import 'package:medisafe/screens/profilScreen/rendezVousScreen/AddRendezVous.dart';


class DesignScreen extends StatefulWidget {
  @override
  _DesignScreenState createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  CategoryType categoryType = CategoryType.ui;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent, // Set background color of AppBar
        title: Text('My Health Tracker',style: TextStyle(
          fontStyle: FontStyle.italic,
        ),), // Set the title of the AppBar
        centerTitle: true, // Center the title of the AppBar
        leading: IconButton( // Add a list icon to the AppBar
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[ // Add a second icon to the right of the AppBar
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>TrackerListScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(

            color: DesignCourseAppTheme.nearlyWhite,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),

                  Expanded(
                    child:  Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  height: 200,
                                  width: 400,
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.07),
                                        child: Container(
                                          height: 200,
                                          width: 340,

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3), // changes the position of the shadow
                                              ),
                                            ],
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 160,
                                        left: 54,
                                        child: Container(
                                          height: 140,
                                          width: 290,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3), // changes the position of the shadow
                                              ),
                                            ],
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: getCategoryUI()
                            ),

                          ],
                        ),
                      ),
                  ),

                ],
              ),
            ),
          ),

          Positioned(
            bottom: 16.0,
            right:MediaQuery.of(context).size.width * 0.422,
            child:FloatingActionButton(
            backgroundColor:  Colors.lightBlueAccent,
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>AddTrackerScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.add_chart,
              color: Colors.white,
            ),
          ),
    )
        ],
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: Text(
                    'Today\'s Trackers',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 0.27,
                      color: DesignCourseAppTheme.darkerText,
                    ),
                  ),
                ),

              ],
            )

        ),


        /*const SizedBox(
          height: 16,
        ),*/
        Container(
            height: 220,
            child: TrackerListView()),
      ],
    );
  }


  Widget getListUI() {
    return Container(

      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 18, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: Text(
                    'Medicament',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 0.27,
                      color: DesignCourseAppTheme.darkerText,
                    ),
                  ),
                ),
                Container(
                  child:GestureDetector(
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => IntroductionAnimationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'new \u2192',
                      textAlign: TextAlign.left,
                      style: TextStyle(

                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.27,
                        color: DesignCourseAppTheme.nearlyBlue,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(

              child: Flexible(
                child: TrackerListView( ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
enum CategoryType {
  ui,
  coding,
  basic,
}


class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
