import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/Tracker.dart';
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
import 'package:provider/provider.dart';

import '../../../models/Mesure.dart';
import '../../../provider/HomeProvider.dart';


class DesignScreen extends StatefulWidget {
  @override
  _DesignScreenState createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen>with TickerProviderStateMixin, ChangeNotifier {
  AnimationController? animationController;
  CategoryType categoryType = CategoryType.ui;
  TextEditingController trackerController = TextEditingController();
  DatabaseHelper trackerservice = DatabaseHelper.instance;
  TextEditingController nomController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController dateFinController = TextEditingController();
  TextEditingController idController = TextEditingController();

  late String nom ="";
  late int idPrincipale = 1;
  late double vHigh = 0;
  late double vLow = 0;
  late double valueP = 0;

  List<Mesure> listMesures = [];

  List<FlSpot> spotss = [];

  int _selectedContainerIndex = 1;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    Future<Tracker> trackerPrincipale = trackerservice.getTrackerById(1);
    trackerPrincipale.then((tracker) async {
      // Handle the list of trackers here
        nomController.text = tracker.nom;
        idController.text =(tracker.id).toString();
        dateFinController.text = tracker.dateFin;
        typeController.text = tracker.type;
        nom = tracker.nom;
        idPrincipale = tracker.id;
    }).catchError((error) {
      // Handle errors here
    });
  }

  String formatDate(String dateString) {
    DateTime date = DateFormat('dd-M-yyyy').parse(dateString);
    return DateFormat('dd-MM-yy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    var changes = Provider.of<HomeProvider>(context, listen: true);
    DatabaseHelper trackerService = DatabaseHelper.instance;
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
                        child: SingleChildScrollView(
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
                                        color: Colors.grey.withOpacity(0.05),
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
                                            child: Padding(
                                              padding: EdgeInsets.only(right:14.0,top: 10),
                                              child: LineChart(
                                                LineChartData(
                                                  borderData: FlBorderData(show: false ),
                                                  minX: 0,
                                                  maxX: 11,
                                                  minY: 0,
                                                  maxY: 6,
                                                  titlesData: LineTitles.getTitleData(),
                                                  lineBarsData: [
                                                    LineChartBarData(
                                                      spots: spotss,

                                                      dotData: FlDotData(show: false),
                                                      isCurved: true,
                                                      colors: [ Color(0xff23b6e6),Color(0xff02d39a)],
                                                      barWidth: 3,
                                                      belowBarData: BarAreaData(show: true,
                                                      colors: [ Color(0xff23b6e6),Color(0xff02d39a)].map((e) => e.withOpacity(0.3)).toList())
                                                    )
                                                  ]
                                                )
                                              ),
                                            ),
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
                                              color: Color(0xFF1E90FF).withOpacity(0.3),
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
                                            child: Row(
                                              children: [
                                                Container(
                                                  width:MediaQuery.of(context).size.width * 0.35,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(6.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.bloodtype, // replace with the icon of your choice
                                                              color: Colors.blue, // set the color of the icon
                                                            ),
                                                            SizedBox(width: 3),
                                                            Text(
                                                              nom.length>10?nom.substring(1,9)+"...":nom, // replace with your title name
                                                              style: TextStyle(
                                                                fontSize: 16, // set the font size of the text
                                                                fontWeight: FontWeight.bold, // set the font weight of the text
                                                                color: Colors.black, // set the color of the text
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                               // initialize the input text variable
                                                              String inputText = "";
                                                              return AlertDialog(
                                                                title: Text('Today\'s mesure '),
                                                                content: TextField(
                                                                  onChanged: (value) {
                                                                    valueP = double.parse(value); // update the input text variable when the user types
                                                                  },
                                                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                  decoration: InputDecoration(
                                                                    hintText: 'Enter value',
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    child: Text('Save'),
                                                                    onPressed: () async {
                                                                      trackerservice.insertMesure(idPrincipale,valueP );
                                                                      ScaffoldMessenger.of(context)
                                                                          .showSnackBar(SnackBar(
                                                                        content: Container(
                                                                            padding: EdgeInsets.only(
                                                                                top: 0, bottom: 2),
                                                                            child: Text(
                                                                              "Mesure inserted successfully",
                                                                              style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  color: Colors.white),
                                                                            )),
                                                                        behavior: SnackBarBehavior.floating,
                                                                        backgroundColor:
                                                                        Color.fromARGB(255, 75, 138, 220),
                                                                        margin: EdgeInsets.only(
                                                                            bottom: 20, left: 25, right: 25),
                                                                      ));
                                                                      Navigator.of(context).pop(inputText);
                                                                      listMesures = await trackerservice.getMesuresByIdTracker(idPrincipale);

                                                                      setState(() {
                                                                        spotss = listMesures.map((mesure) {
                                                                          double mappedValue = ((double.parse(mesure.value) - 70) / (200 - 70)) * (6 - 1) + 1;
                                                                          return FlSpot(double.parse(mesure.id.toString()) , mappedValue);
                                                                        }).toList();
                                                                      });

                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );

                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left:25.0),
                                                          child: SizedBox(
                                                            width: 60,
                                                            height: 60,
                                                            child: Image.asset("assets/images/click.png"),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:  EdgeInsets.only(left:100,top: 6),
                                                        child: Icon(Icons.navigate_next),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:  EdgeInsets.only(bottom: 10,right: 12),
                                                                  child: SizedBox(
                                                                    width: 12,
                                                                    height: 12,
                                                                    child: Icon(Icons.arrow_upward_outlined, color: Colors.grey),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Highest',
                                                                  style: TextStyle(
                                                                    color: Colors.grey.withOpacity(0.3),
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    shadows: [
                                                                      Shadow(
                                                                        blurRadius: 1.5,
                                                                        color: Colors.black.withOpacity(0.5),
                                                                        offset: Offset(2.0, 2.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            SizedBox(width: 10),
                                                            Row(
                                                              children: [
                                                                Text(vHigh.toString(), style: TextStyle(fontSize: 14)),
                                                                Text('  mg/dl', style: TextStyle(fontSize: 12,color: Colors.grey.withOpacity(0.6),fontStyle: FontStyle.italic))
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:  EdgeInsets.only(bottom: 10.0,right:12),
                                                                  child: SizedBox(
                                                                    width: 12,
                                                                    height: 12,
                                                                    child: Icon(Icons.arrow_downward_sharp, color: Colors.grey),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Lowest',
                                                                  style: TextStyle(
                                                                    color: Colors.grey.withOpacity(0.3),
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    shadows: [
                                                                      Shadow(
                                                                        blurRadius: 1.5,
                                                                        color: Colors.black.withOpacity(0.5),
                                                                        offset: Offset(2.0, 2.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(width: 10),
                                                            Row(
                                                              children: [
                                                                Text(vLow.toString(), style: TextStyle(fontSize: 14)),
                                                                Text('  mg/dl', style: TextStyle(fontSize: 12,color: Colors.grey.withOpacity(0.6),fontStyle: FontStyle.italic)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
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
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: getCategoryUI()
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              FloatingActionButton(
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

                            ],
                          ),
                        ),
                      ),
                  ),

                ],
              ),
            ),
          ),


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
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: FutureBuilder<List<Tracker>>(
                      future: trackerservice.allTrackers(),
                      builder: (context,  snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: Text("wait"),
                          );
                        } else if (snapshot.hasError) {
                          final error = snapshot.error;
                          return Center(
                            child: Text(error.toString()),
                          );
                        } else if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text("Try to add new one"),
                            );
                          }else{
                            return GridView(
                              padding: const EdgeInsets.all(8),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 32.0,
                                childAspectRatio: 0.8,
                              ),
                              children: List<Widget>.generate(
                                snapshot.data!.length,
                                    (int index) {
                                  final int count = snapshot.data!.length;
                                  final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn),
                                    ),
                                  );
                                  animationController?.forward();
                                  return Container(

                                    height: MediaQuery.of(context).size.height * 0.7,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {

                                              print(snapshot.data![index].id);
                                              nom = snapshot.data![index].nom;
                                              idPrincipale = snapshot.data![index].id;

                                              vHigh = await trackerservice.getHighest(idPrincipale);
                                              vLow = await trackerservice.getLowest(idPrincipale);
                                              listMesures = await trackerservice.getMesuresByIdTracker(idPrincipale);


                                              setState(() {
                                                _selectedContainerIndex = snapshot.data![index].id;
                                                spotss = listMesures.map((mesure) {
                                                  double mappedValue = ((double.parse(mesure.value) - 70) / (200 - 70)) * (6 - 1) + 1;
                                                  return FlSpot(double.parse(mesure.id.toString()) , mappedValue);
                                                }).toList();
                                                print("${vLow} ++  ${vHigh}");
                                              });

                                              //_showForm(widget.category!.id);
                                              // _delete(snapshot.data![index].id);
                                              //
                                              // changes.setChanges();
                                            },
                                            child: Container(
                                              decoration: _selectedContainerIndex == snapshot.data![index].id
                                                  ? BoxDecoration(
                                                color: Colors.blue
                                                     ,
                                                borderRadius: BorderRadius.circular(10),
                                              )
                                             : BoxDecoration(
                                                color: HexColor('#F8FAFB'),

                                                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                                                // border: new Border.all(
                                                //     color: DesignCourseAppTheme.notWhite),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.only(
                                                                top: 16, left: 16, right: 16),
                                                            child: Text(
                                                              snapshot.data![index].nom,
                                                              textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16,
                                                                letterSpacing: 0.27,
                                                                color:_selectedContainerIndex != snapshot.data![index].id
                                                                    ? DesignCourseAppTheme.darkerText:Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(
                                                                top: 8, left: 16, right: 16, bottom: 8),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                 Text(
                                                                  'End :',
                                                                  textAlign: TextAlign.right,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 12,
                                                                    letterSpacing: 0.27,
                                                                    color: _selectedContainerIndex != snapshot.data![index].id
                                                                        ? DesignCourseAppTheme.grey:Colors.white,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Text(
                                                                        '${formatDate(snapshot.data![index].dateFin)}',
                                                                        textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.w200,
                                                                          fontSize: 18,
                                                                          letterSpacing: 0.27,
                                                                          color: DesignCourseAppTheme.grey,
                                                                        ),
                                                                      ),
                                                                      Icon(
                                                                        Icons.calendar_month,
                                                                        color: DesignCourseAppTheme.nearlyBlue,
                                                                        size: 18,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              child: SizedBox(
                                                                height: 75,
                                                                width: 128,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      top: 0, right: 16, left: 16),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius.all(
                                                                          Radius.circular(16.0)),
                                                                      boxShadow: <BoxShadow>[
                                                                        BoxShadow(
                                                                            color: DesignCourseAppTheme.grey
                                                                                .withOpacity(0.2),
                                                                            offset: const Offset(0.0, 0.0),
                                                                            blurRadius: 6.0),
                                                                      ],
                                                                    ),
                                                                    child: ClipRRect(
                                                                      borderRadius: const BorderRadius.all(
                                                                          Radius.circular(16.0)),
                                                                      child: AspectRatio(
                                                                          aspectRatio: 1.28,
                                                                          child:
                                                                          Image.asset(snapshot.data![index].type=="glycémie"?'assets/images/glycemie.png':'assets/images/blood-pressure.png')),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );}
                        }
                        return Container();
                      }
                  ),
                ),
              ),
            ),),
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


class CategoryView extends StatefulWidget {
  const CategoryView(
      {Key? key,
        this.category,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Medicament? category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {


  @override
  Widget build(BuildContext context) {
    DatabaseHelper medicamentService = DatabaseHelper.instance;

    // void _delete(int id) async {
    //   await medicamentService.deleteMedicament(id);
    //
    //   setState(() {
    //     widget.category?.dod(Category(
    //       id: id,
    //       imagePath: 'assets/images/medicine.png',
    //       title: widget.category!.title,
    //       date: widget.category!.date,
    //       etat: false,
    //       heure: widget.category!.heure,
    //     ));
    //   });
    // }

    void _delete(int id) async {
      await medicamentService.deleteMedicament(id);

      setState(() {
        Medicament.popularCourseList.removeWhere((category) => category.id == id);
        print(Medicament.categoryList.toString());
      });
    }




    void _showForm(int? id) async{


      final medi = await medicamentService.getMedicamentById(id!);

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: TextEditingController(text: medi[0]['nom']),
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width * 0.05 ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push<dynamic>(
                          //   context,
                          //   MaterialPageRoute<dynamic>(
                          //     builder: (BuildContext context) => ProfileSettingScreen(
                          //
                          //
                          //     ),
                          //   ),
                          // );

                          // Perform action when 'Yes' button is pressed
                          Navigator.pop(context);
                          // ... do something else ...
                        },
                        child: Text('Update'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _delete(id);

                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );

    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                _showForm(widget.category!.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),

                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  // border: new Border.all(
                  //     color: DesignCourseAppTheme.notWhite),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              child: Text(
                                widget.category!.title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: 0.27,
                                  color: DesignCourseAppTheme.darkerText,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 16, right: 16, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'end :',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.grey,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '${widget.category!.dateDebut}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 18,
                                            letterSpacing: 0.27,
                                            color: DesignCourseAppTheme.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_month,
                                          color: DesignCourseAppTheme.nearlyBlue,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: SizedBox(
                                  height: 75,
                                  width: 128,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, right: 16, left: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: DesignCourseAppTheme.grey
                                                  .withOpacity(0.2),
                                              offset: const Offset(0.0, 0.0),
                                              blurRadius: 6.0),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        child: AspectRatio(
                                            aspectRatio: 1.28,
                                            child:
                                            Image.asset(widget.category!.imagePath)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
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



class LineTitles {
  static getTitleData() => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      reservedSize: 35,
      getTextStyles: (value) => const TextStyle(
        color: Color(0xff68737d),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 2:
            return 'MAR';
          case 5:
            return 'JUN';
          case 8:
            return 'SEP';
        }
        return '';
      },
      margin: 8,
    ),
    leftTitles: SideTitles(
      showTitles: true,
      getTextStyles: (value) => const TextStyle(
        color: Color(0xff67727d),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 1:
            return '70';
          case 3:
            return '140 ';
          case 5:
            return '200';
        }
        return '';
      },
      reservedSize: 35,
      margin: 12,
    ),
  );
}