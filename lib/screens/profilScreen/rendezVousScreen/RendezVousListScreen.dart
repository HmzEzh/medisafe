import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/models/medcin.dart';
import 'package:medisafe/models/rendezVous.dart';
import 'package:medisafe/screens/profilScreen/MedecinScreen/MedcinsInfosScreen.dart';
import 'package:provider/provider.dart';
import '../../../helpers/DatabaseHelper.dart';
import '../../../service/RendezVousService.dart';
import '../../../provider/HomeProvider.dart';
import 'AddRendezVous.dart';
import 'RendezVousInfoScreen.dart';

class RendezVousListScreen extends StatefulWidget {
  const RendezVousListScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<RendezVousListScreen> createState() => _RendezVousListScreenState();
}

class _RendezVousListScreenState extends State<RendezVousListScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  RendezVousService rendezVousService = new RendezVousService();
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var changes = Provider.of<HomeProvider>(context, listen: true);
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
                    //TODO:
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => AddRendezVous()),
                    );
                  },
                  child: Icon(
                    IconData(0xe047, fontFamily: 'MaterialIcons'),
                    color: Color.fromARGB(255, 38, 58, 167),
                  ))
            ]),
        backgroundColor: Colors.white,
        body: Container(
          //color:Color.fromARGB(255, 246, 246, 246),
          child: FutureBuilder<List>(
              future: rendezVousService.allRendezVous(),
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
                      child: Text("isEmpty"),
                    );
                  }

                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        // Medcin med = await rendezVousService.findMedecin(snapshot.data![index].medecinId);
                        return InkWell(
                          onTap: () {
                            //TODO:
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      RendezVousInfoScreen(
                                        rendezVous: snapshot.data![index],
                                      )),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 0,right: 16,top: 6,bottom: 6),
                                //height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      child: Center(child: Image.asset("assets/images/calendarDone.png", scale: 3.5)),
                                    ),
                                    Container(
                                      child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                                margin: EdgeInsets.only(left: 0,bottom: 4),
                                                 child: Text(
                                                  snapshot.data![index].nom,
                                                  style: TextStyle(fontSize: 16),
                                                                                 ),
                                               ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: 0, bottom: 0, left: 0),
                                          child: Text(snapshot.data![index].heure,style: TextStyle(fontSize: 14,
                                          color: Color.fromARGB(255, 124, 123, 123))),
                                        ),
                                        Container(
                                          width: 3*size.width/4,
                                          margin: EdgeInsets.only(
                                              top: 0, bottom: 0, left: 0),
                                          child: Text(snapshot.data![index].remarque,
                                          style: TextStyle(fontSize: 14,
                                          color: Color.fromARGB(255, 124, 123, 123)),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,),
                                        ),
                                      
                                    ]),
                                    )
                              
                                  ],
                                ),
                              ),
                              Divider(
                                        height: 2,
                                        indent: 60,
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
