import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:medisafe/models/raport.dart';
import 'package:provider/provider.dart';
import '../../../app_skoleton/appSkoleton.dart';
import '../../../helpers/DatabaseHelper.dart';
import '../../../models/HistoriqueDoze.dart';
import '../../../models/medicament.dart';
import '../../../provider/HomeProvider.dart';
import '../../../service/raportService/pdf_report_api.dart';
import '../../../utils/utils.dart';
import 'package:badges/badges.dart' as badges;


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
  DateTime datedebut = DateTime.now().subtract(const Duration(days: 8));
  DateTime datefin = DateTime.now();
  String debut = "";
  String fin = "";
  Medicament? medicament;

  @override
  void initState() {
    debut = Utils.formatDate2(datedebut);
    fin = Utils.formatDate2(datefin);
  }

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
    Size size = MediaQuery.of(context).size;
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
                  List<Raport> raport =
                      await db.raportApiPdf(datedebut, datefin, medicament);
                  PdfReportApi.generate(datedebut, datefin, raport) ;
                  // for (var item in raport) {
                  //   print("###################");
                  //   print(item.name);
                  // }
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
        ),
        SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder<Map<String, Map<String, List<Raport>>>>(
                future: db.raportApi(datedebut, datefin, medicament),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: 6,
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppSkoleton(
                                    width: size.width / 3,
                                    height: 25,
                                    margin:
                                        EdgeInsets.only(left: 16, bottom: 8),
                                    radius:
                                        BorderRadius.all(Radius.circular(8))),
                                Container(
                                  //color: Color.fromARGB(255, 202, 199, 199),
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppSkoleton(
                                          width: size.width / 4,
                                          height: 20,
                                          margin: EdgeInsets.only(
                                              left: 32, bottom: 8),
                                          radius: BorderRadius.all(
                                              Radius.circular(8))),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: 3,
                                          itemBuilder: (ctx, index) {
                                            return Row(
                                              children: [
                                                AppSkoleton(
                                                    width: 40,
                                                    height: 40,
                                                    margin: EdgeInsets.only(
                                                        left: 32 + 16,
                                                        bottom: 8),
                                                    radius: BorderRadius.all(
                                                        Radius.circular(90))),
                                                AppSkoleton(
                                                    width: size.width /
                                                        (index + 2),
                                                    height: 20,
                                                    margin: EdgeInsets.only(
                                                        left: 8, bottom: 8),
                                                    radius: BorderRadius.all(
                                                        Radius.circular(8))),
                                              ],
                                            );
                                          }),
                                      AppSkoleton(
                                          width: size.width / 4,
                                          height: 20,
                                          margin: EdgeInsets.only(
                                              left: 32, bottom: 8),
                                          radius: BorderRadius.all(
                                              Radius.circular(8))),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: 2,
                                          itemBuilder: (ctx, index) {
                                            return Row(
                                              children: [
                                                AppSkoleton(
                                                    width: 40,
                                                    height: 40,
                                                    margin: EdgeInsets.only(
                                                        left: 32 + 16,
                                                        bottom: 8),
                                                    radius: BorderRadius.all(
                                                        Radius.circular(90))),
                                                AppSkoleton(
                                                    width: size.width /
                                                        (index + 2),
                                                    height: 20,
                                                    margin: EdgeInsets.only(
                                                        left: 8, bottom: 8),
                                                    radius: BorderRadius.all(
                                                        Radius.circular(8))),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                )
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Image.asset("assets/images/emptyState.png",
                                  scale: 1.2),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Text("Pas de médicament",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600))),
                            Container(
                                margin: EdgeInsets.only(
                                    top: 8, left: 32, right: 32),
                                child: Text(
                                    "Ajouter vos médicaments pour recevoire un rappel et suivre votre santé",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17)))
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          //margin: EdgeInsets.only(bottom: 20, left: 24, right: 24),
                          padding: EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 8, left: 16),
                                child: Text(
                                    snapshot.data!.keys.elementAt(index),
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                              ),
                              body(context,
                                  snapshot.data!.values.elementAt(index))
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                }),
          ),
        )
      ]),
    );
  }

  body(BuildContext context, Map<String, List<Raport>> data) {
    Size size = MediaQuery.of(context).size;
    int prisCompt = data['pris']!.length;
    int manqueCompt = data['non pris']!.length;
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 32),
      width: size.width,
      //height: 200,
      color: Color.fromARGB(255, 246, 246, 246),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text("MANQUÉ ($manqueCompt)",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: data['non pris']!.length,
              itemBuilder: (ctx, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child:badges.Badge(
                                    position: badges.BadgePosition.topEnd(
                                        top: -5, end: -6),
                                    showBadge: true,
                                    ignorePointer: false,
                                    badgeContent: Icon(Icons.close,
                                        color: Colors.white, size: 10),
                                    badgeStyle: badges.BadgeStyle(
                                      shape: badges.BadgeShape.circle,
                                      badgeColor: Colors.red,
                                      padding: EdgeInsets.all(3),
                                    ),
                                    child: Image.asset(
                                       data['non pris']![index].imagePath,
                                        scale: 4),
                                  ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                            data['non pris']![index].name +
                                ', ' +
                                data['non pris']![index]
                                    .datePrevu
                                    .split(" ")[1],
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
              child: Text(
            "PRIS ($prisCompt)",
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          )),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: data['pris']!.length,
              itemBuilder: (ctx, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child:badges.Badge(
                                    position: badges.BadgePosition.topEnd(
                                         top: -5, end: -6),
                                    showBadge: true,
                                    ignorePointer: false,
                                    badgeContent: Icon(Icons.check,
                                        color: Colors.white, size: 10),
                                    badgeStyle: badges.BadgeStyle(
                                      shape: badges.BadgeShape.circle,
                                      badgeColor: Colors.green,
                                      padding: EdgeInsets.all(3),
                                    ),
                                    child: Image.asset(
                                       data['pris']![index].imagePath,
                                        scale: 4),
                                  ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                            data['pris']![index].name +
                                ', ' +
                                data['pris']![index].datePrevu.split(" ")[1],
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
