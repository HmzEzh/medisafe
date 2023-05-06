import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../../helpers/DatabaseHelper.dart';
import '../../../models/medcin.dart';
import '../../../models/medicament.dart';
import '../../../models/raport.dart';
import '../../../provider/HomeProvider.dart';
import '../../../service/raportService/pdf_report_api.dart';
import '../../../utils/utils.dart';

class MedcinsInfosScreen extends StatefulWidget {
  const MedcinsInfosScreen({
    Key? key,
    required this.doctor,
  }) : super(key: key);
  final Medcin doctor;
  @override
  State<MedcinsInfosScreen> createState() => _MedcinsInfosScreenState();
}

class _MedcinsInfosScreenState extends State<MedcinsInfosScreen> {
  DatabaseHelper medcinService = DatabaseHelper.instance;

  final TextEditingController nomController = TextEditingController();
  final TextEditingController specialiteController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bureauController = TextEditingController();
  final TextEditingController teleController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  DateTime datedebut = DateTime.now().subtract(const Duration(days: 8));
  DateTime datefin = DateTime.now();
  String debut = "";
  String fin = "";
  Medicament? medicament;

  @override
  void initState() {
    nomController.text = widget.doctor.nom;
    specialiteController.text = widget.doctor.specialite;
    emailController.text = widget.doctor.email;
    bureauController.text = widget.doctor.bureau;
    teleController.text = widget.doctor.tele;
    adresseController.text = widget.doctor.adress;
    debut = Utils.formatDate2(datedebut);
    fin = Utils.formatDate2(datefin);
  }

  Widget section1(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(255, 38, 58, 167),
                  child: widget.doctor.nom.length >= 2
                      ? Text(widget.doctor.nom.substring(0, 2))
                      : Text(widget.doctor.nom)),
              Spacer(
                flex: 1,
              ),
              Container(
                width: size.width - 100,
                child: TextFormField(
                  controller: nomController,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 20,
              )
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 62,
          endIndent: 24,
        ),
        Container(
          //color: Color.fromARGB(255, 246, 246, 246),
          child: TextFormField(
            controller: specialiteController,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget section2(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        InkWell(
          onTap: () {
            showModalBottomSheet<void>(
                constraints: BoxConstraints(
                    minWidth: size.width,
                    maxHeight: size.height - 100,
                    minHeight: size.height - 100),
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0))),
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(

                        //margin: EdgeInsets.only(top: 8),
                        child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              TextButton(
                                  style: ButtonStyle(
                                    // minimumSize : MaterialStateProperty.all(Size(0,0)),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    splashFactory: NoSplash.splashFactory,
                                  ),
                                  onPressed: () async {
                                    Medcin medcin = new Medcin(
                                      id: 0,
                                      nom: nomController.text,
                                      specialite: specialiteController.text,
                                      email: emailController.text,
                                      tele: teleController.text,
                                      adress: adresseController.text,
                                      bureau: bureauController.text,
                                    );
                                    try {
                                      if (nomController.text.length == 0) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  insetPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 70),
                                                  buttonPadding:
                                                      EdgeInsets.zero,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          0.0, 24.0, 0.0, 0.0),
                                                  // title: const Text(
                                                  //   'La connexion a échoué',
                                                  //   textAlign: TextAlign.center,
                                                  //   style:
                                                  //       TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                                  // ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 8,
                                                            right: 8,
                                                            bottom: 24),
                                                        child: Text(
                                                          "Veuillez entrez le nom de votre médecin",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: InkWell(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                            ),
                                                            onTap: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                top: BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                              )),
                                                              height: 50,
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                    "OK",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ),
                                                            ),
                                                          ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ));
                                      } else {
                                        await medcinService.updateMedecin(
                                            medcin.toMap(), widget.doctor.id);

                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                      }
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  },
                                  child: Text(
                                    "Mettre à jour",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 38, 58, 167)),
                                  ))
                            ],
                          ),
                          coor(context),
                          section3(context)
                        ],
                      ),
                    ));
                  });
                });
          },
          child: Container(
            height: 40,
            child: Row(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    width: 10,
                    child: Icon(
                      Icons.contact_mail_outlined,
                      color: Colors.blue,
                    )),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text("Coordonnées")),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Container(
          height: 40,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16),
                width: 10,
                child: Icon(
                 Icons.calendar_today,
                  color: Colors.blue,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("Rendez-vous")),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Container(
          height: 40,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16),
                width: 10,
                child: Icon(
                  Icons.medication_liquid,
                  color: Colors.blue,
                  size:28
               
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("Médicaments")),
            ],
          ),
        )
      ]),
    );
  }

  Widget section3(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                controller: adresseController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget coor(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                IconData(0xf018, fontFamily: 'MaterialIcons'),
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.business_outlined,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                controller: bureauController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.phone_iphone_outlined,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                controller: teleController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
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
              Text("Modifier medecin",
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
                  Medcin medcin = new Medcin(
                    id: 0,
                    nom: nomController.text,
                    specialite: specialiteController.text,
                    email: emailController.text,
                    tele: teleController.text,
                    adress: adresseController.text,
                    bureau: bureauController.text,
                  );
                  try {
                    if (nomController.text.length == 0) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                insetPadding:
                                    EdgeInsets.symmetric(horizontal: 70),
                                buttonPadding: EdgeInsets.zero,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    0.0, 24.0, 0.0, 0.0),
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
                                      margin: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 24),
                                      child: Text(
                                        "Veuillez entrez le nom de votre médecin",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: InkWell(
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey),
                                            )),
                                            height: 50,
                                            child: const Center(
                                              child: Text("OK",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                        ))
                                      ],
                                    )
                                  ],
                                ),
                              ));
                    } else {
                      await medcinService.updateMedecin(
                          medcin.toMap(), widget.doctor.id);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                            padding: EdgeInsets.only(top: 0, bottom: 2),
                            child: Text(
                              "Enregistré",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Color.fromARGB(255, 75, 138, 220),
                        margin:
                            EdgeInsets.only(bottom: 20, left: 25, right: 25),
                      ));
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Text(
                  "Mettre à jour",
                  style: TextStyle(color: Colors.white),
                ))
          ]),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          section1(context),
          section2(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            padding: EdgeInsets.only(top: 8, bottom: 8),
            margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 27, 62, 92),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              // border: Border.all(
              //     color: DesignCourseAppTheme.nearlyBlue)
            ),
            child: InkWell(
              child: Container(
                child: Center(
                  child: Text("Envoyer un rapport du statu au médecin",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
              ),
              onTap: () {
                Size size = MediaQuery.of(context).size;
                showModalBottomSheet<void>(
                    constraints: BoxConstraints(
                        minWidth: size.width,
                        maxHeight: size.height - 100,
                        minHeight: size.height/4),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0))),
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Container(

                            //margin: EdgeInsets.only(top: 8),
                            child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(children: [
                                  Row(
                            children: [
                              Container(
                                margin:EdgeInsets.only(left: 8,top:8),
                                child: TextButton(
                                    style: ButtonStyle(
                                      // minimumSize : MaterialStateProperty.all(Size(0,0)),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    onPressed: () async {
                                      //TODO:
                                     
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Annuler",
                                      style: TextStyle(
                                          color:Color.fromARGB(255, 38, 58, 167),
                                          fontWeight: FontWeight.normal),
                                    )),
                              ),
                              Spacer(),
                              Container(
                                margin:EdgeInsets.only(right: 8,top:8),
                                child: TextButton(
                                    style: ButtonStyle(
                                      // minimumSize : MaterialStateProperty.all(Size(0,0)),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    onPressed: () async {
                                      //TODO:
                                      List<Raport> raport = await medcinService.raportApiPdf(datedebut, datefin, medicament);
                                      PdfReportApi.generate(datedebut, datefin, raport) ;
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Envoyer",
                                      style: TextStyle(
                                          color:Color.fromARGB(255, 38, 58, 167),
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                          Container(
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
                                    future: medcinService.getAllMedicaments(),
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
    )
                                ])));
                      });
                    });
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            padding: EdgeInsets.only(top: 8, bottom: 8),
            margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 246, 246, 246),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              // border: Border.all(
              //     color: DesignCourseAppTheme.nearlyBlue)
            ),
            child: InkWell(
              child: Container(
                child: Center(
                  child: Text("Supprimer Médecin",
                      style: TextStyle(
                          color: Color.fromARGB(255, 243, 19, 19),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 60),
                          buttonPadding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          contentPadding:
                              const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
                          title: const Text(
                            'Déconnexion',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 200,
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 24),
                                child: const Text(
                                  "Voulez-vous vraiment vous déconnecter ?",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              right: BorderSide(
                                                  color: Colors.grey))),
                                      height: 50,
                                      child: const Center(
                                        child: Text("Annuler",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: InkWell(
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    ),
                                    //TODO:
                                    onTap: () async {
                                      try {
                                        Navigator.pop(context);
                                        await medcinService
                                            .deleteMedecin(widget.doctor.id);
                                        Navigator.pop(context);
                                        changes.setChanges();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Container(
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 2),
                                              child: Text(
                                                "Enregistré",
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
                                      } catch (e) {}
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        top: BorderSide(color: Colors.grey),
                                      )),
                                      height: 50,
                                      child: const Center(
                                        child: Text(
                                          "Supprimer",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
