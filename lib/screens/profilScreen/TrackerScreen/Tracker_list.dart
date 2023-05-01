import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/Tracker_info.dart';
import 'package:provider/provider.dart';
import '../../../helpers/DatabaseHelper.dart';
import '../../../models/Tracker.dart';
import '../../../provider/HomeProvider.dart';
import 'add_track.dart';

class TrackerListScreen extends StatefulWidget {
  const TrackerListScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<TrackerListScreen> createState() => _TrackerListScreenState();
}

class _TrackerListScreenState extends State<TrackerListScreen>
    with TickerProviderStateMixin {
  DatabaseHelper trackerService = DatabaseHelper.instance;
  AnimationController? animationController;

  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    super.initState();
  }

  String check(String type){
    if(type == "glycémie"){
      return 'assets/images/glycemie.png';
    }else{
      return 'assets/images/blood-pressure.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var changes = Provider.of<HomeProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      IconData(0xe16a, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    )),
                Spacer(),
                Text("Trackers",
                    style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Spacer(),
              ],
            ),
            shadowColor: Colors.transparent,
            backgroundColor:Color.fromARGB(255, 27, 62, 92),
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
                          builder: (BuildContext context) => AddTrackerScreen()),
                    );
                  },
                  child: Icon(
                    IconData(0xe047, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ))
            ]),
        backgroundColor: Colors.white,
        body: Container(
          //color:Color.fromARGB(255, 246, 246, 246),
          child: FutureBuilder<List<Tracker>>(
              future: trackerService.allTrackers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: Color.fromARGB(36, 81, 86, 90)),
                          child: Center(
                              child: CupertinoActivityIndicator(
                                radius: 20,
                              )),
                        )),
                  );
                } else if (snapshot.hasError) {
                  final error = snapshot.error;
                  return Center(
                    child: Text(error.toString()),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child:
                            Image.asset("assets/images/sync.png", scale: 5),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Text(
                                'Add new Tracker',
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.3),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 1.5,
                                      color: Colors.black.withOpacity(0.5),
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),),

                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {

                        return InkWell(
                          onTap: () {
                            print(snapshot.data![index].id);
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      TrackerInfo(tracker: snapshot.data![index],)),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  //color: Color.fromARGB(255, 246, 246, 246),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Container(
                                        //color: Colors.black,
                                        margin: EdgeInsets.only(right: 16),
                                        child: Image.asset(check(snapshot.data![index].type), scale: 3),
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Text(
                                        snapshot.data![index].nom,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Spacer(
                                        flex: 20,
                                      )
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
                        );
                      });
                }
                return Container();
              }),
        ));
  }
}
