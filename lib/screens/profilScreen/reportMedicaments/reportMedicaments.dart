import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import '../../../helpers/DatabaseHelper.dart';
import '../../../models/HistoriqueDoze.dart';
import '../../../models/medicament.dart';
import '../../../provider/HomeProvider.dart';
import '../../../utils/utils.dart';

class ReportMedicamentsScreen extends StatefulWidget {
  const ReportMedicamentsScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<ReportMedicamentsScreen> createState() =>
      _ReportMedicamentsScreenState();
}

class _ReportMedicamentsScreenState extends State<ReportMedicamentsScreen> {
  DatabaseHelper db = DatabaseHelper.instance;
  DateTime datedebut = DateTime.now();
  DateTime datefin = DateTime.now();
  String debut = "";
  String fin = "";
  Medicament? medicament;

  @override
  void initState() {}

  Widget section1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 246, 246, 246),
      child: Row(
        children: [
          Container(
            width: size.width / 2,
            child: Column(children: [
              Container(
                width: size.width / 2,
                height: 35,
                child: InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2023, 1, 1),
                        maxTime: DateTime(2024, 12, 31), onConfirm: (date) {
                      print(date);
                      setState(() {
                        // heureController.text = '$date'
                        // TODO:
                        datedebut = date;
                        debut = Utils.formatDate2(date);
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.fr);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 0, bottom: 0, left: 8),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Text("Date de début : $debut",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                          ])),
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 2,
                indent: 16,
                endIndent: 16,
              ),
              Container(
                height: 35,
                width: size.width / 2,
                child: InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2023, 1, 1),
                        maxTime: DateTime(2024, 12, 31), onConfirm: (date) {
                      print(date);
                      setState(() {
                        // heureController.text = '$date'
                        // TODO:
                        datefin = date;
                        fin = Utils.formatDate2(date);
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.fr);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 0, bottom: 0, left: 8),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Text("Date de fin : $fin",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                          ])),
                ),
              )
            ]),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.all(10),
            child: const VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              width: 0,
            ),
          ),
          Expanded(
              child: Container(
            height: 70,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 50),
                          buttonPadding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          contentPadding:
                              const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  medicament = null;
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  width: size.width,
                                  height: 50,
                                  //height: 200,
                                  margin: EdgeInsets.only(
                                      top: 4, bottom: 0, left: 8, right: 8),
                                  child: Center(
                                      child: Text(
                                    "Tous Meds",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )),
                                ),
                              ),
                              Container(
                                //margin: EdgeInsets.only(top: 0, bottom: 0, left: 24, right: 24),
                                height: size.height / 3,
                                width: size.width,
                                //color:Color.fromARGB(255, 246, 246, 246),
                                child: FutureBuilder<List<Medicament>>(
                                    future: db.getAllMedicaments(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: Center(
                                              child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                color: Color.fromARGB(
                                                    36, 81, 86, 90)),
                                            child: Center(
                                                child:
                                                    CupertinoActivityIndicator(
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

                                        return Container(
                                          child: ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (ctx, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    //TODO:
                                                    medicament =
                                                        snapshot.data![index];

                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          //color: Color.fromARGB(255, 246, 246, 246),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          // border: Border.all(
                                                          //     color: DesignCourseAppTheme.nearlyBlue)
                                                        ),

                                                        width: size.width,
                                                        height: 50,
                                                        //height: 200,
                                                        margin: EdgeInsets.only(
                                                            top: 4,
                                                            bottom: 0,
                                                            left: 8,
                                                            right: 8),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Spacer(
                                                                flex: 1,
                                                              ),
                                                              Image.asset(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .imagePath,
                                                                  scale: 4),
                                                              Spacer(
                                                                flex: 1,
                                                              ),
                                                              Container(
                                                                width:
                                                                    size.width /
                                                                        4,
                                                                child: Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .title,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                ),
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
                                                        indent: 0,
                                                        endIndent: 0,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        );
                                      }
                                      return Container();
                                    }),
                              ),
                            ],
                          ),
                        ));
              },
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: medicament == null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    Container(
                                      child: Text(
                                        "Tous Meds",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ])
                            : Container(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(medicament!.imagePath,
                                          scale: 4),
                                      Container(
                                        width: size.width / 5,
                                        child: Text(
                                          medicament!.title,
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      )
                    ]),
              ),
            ),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              const Text("Rapport",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Spacer(),
            ],
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Color.fromARGB(255, 27, 62, 92),
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
                  //TODO:
                  Map<String, Map<String, List<HistoriqueDoze>>> ha = await db.reportApi(datedebut, datefin, medicament);
                  for (var item in ha.entries) {
                    String i = item.key;
                    print("######### $i #############");
                    print("######### pris #############");
                    for (var j in item.value['pris']!) {
                      print(j.idMedicament);
                    }
                    print("######### non pris #############");
                    for (var j in item.value['non pris']!) {
                      print(j.idMedicament);
                    }
                  }
                },
                child: const Text(
                  "Envoyer",
                  style: TextStyle(color: Colors.white),
                ))
          ]),
      backgroundColor: Colors.white,
      body: Column(children: [
        section1(context),
        const Divider(
          color: Colors.grey,
          height: 2,
          indent: 0,
          endIndent: 0,
        )
      ]),
    );
  }
}
