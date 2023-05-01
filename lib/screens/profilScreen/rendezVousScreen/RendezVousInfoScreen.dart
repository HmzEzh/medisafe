import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:medisafe/service/RendezVousService.dart';
import 'package:provider/provider.dart';
import '../../../helpers/DatabaseHelper.dart';
import '../../../models/RendezVous.dart';
import '../../../models/medcin.dart';
import '../../../provider/HomeProvider.dart';
import '../../../utils/utils.dart';

class RendezVousInfoScreen extends StatefulWidget {
  const RendezVousInfoScreen({
    Key? key,
    required this.rendezVous,
  }) : super(key: key);
  final RendezVous rendezVous;
  @override
  State<RendezVousInfoScreen> createState() => _RendezVousInfoScreenState();
}

class _RendezVousInfoScreenState extends State<RendezVousInfoScreen> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController medecinIdController = TextEditingController();
  final TextEditingController lieuController = TextEditingController();
  final TextEditingController remarqueController = TextEditingController();
  final TextEditingController heureController = TextEditingController();
  Medcin medecin = new Medcin(
      id: 0,
      nom: "nom",
      specialite: "specialite",
      email: "email",
      adress: "adress",
      tele: "tele",
      bureau: "bureau");
  var a = "";
  var b = "";

  DatabaseHelper medcinService = DatabaseHelper.instance;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  RendezVousService rendezVousService = new RendezVousService();

  Future<void> initDoctore() async {
    medecin = await rendezVousService.findMedecin(widget.rendezVous.medecinId);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    initDoctore();
    nomController.text = widget.rendezVous.nom;
    //medecinIdController.text = widget.rendezVous.medecinId;
    lieuController.text = widget.rendezVous.lieu;
    remarqueController.text = widget.rendezVous.remarque;
    heureController.text = widget.rendezVous.heure;

    super.initState();
  }

  Widget section1(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 246, 246, 246),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            // border: Border.all(
            //     color: DesignCourseAppTheme.nearlyBlue)
          ),
          width: size.width,
          //height: 200,
          margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
          //color: Colors.red,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: TextFormField(
                    controller: nomController,
                    decoration: InputDecoration(
                      hintText: "Nom du médcin",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 2,
                  indent: 24,
                  endIndent: 24,
                ),
              ]),
        ),
        InkWell(
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
                      content: Container(
                        //margin: EdgeInsets.only(top: 0, bottom: 0, left: 24, right: 24),
                        height: size.height / 3,
                        width: size.width,
                        //color:Color.fromARGB(255, 246, 246, 246),
                        child: FutureBuilder<List<Medcin>>(
                            future: medcinService.queryAllRowsMedecin(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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

                                return Container(
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (ctx, index) {
                                        return InkWell(
                                          onTap: () {
                                            medecin = snapshot.data![index];
                                            int id = snapshot.data![index].id;
                                            //TODO:
                                            medecinIdController.text = '$id';
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  //color: Color.fromARGB(255, 246, 246, 246),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(4)),
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
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                38, 58, 167),
                                                        child: snapshot
                                                                    .data![
                                                                        index]
                                                                    .nom
                                                                    .length >=
                                                                2
                                                            ? Text(snapshot
                                                                .data![index]
                                                                .nom
                                                                .substring(
                                                                    0, 2))
                                                            : Text(snapshot
                                                                .data![index]
                                                                .nom),
                                                      ),
                                                      Spacer(
                                                        flex: 1,
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data![index].nom,
                                                        style: TextStyle(
                                                            fontSize: 16),
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
                    ));
          },
          child: Container(
            padding: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 246, 246, 246),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4)),
            ),
            width: size.width,
            margin: EdgeInsets.only(bottom: 0, left: 8, right: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    // child: medecinIdController.text == ""
                    //     ? Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //             Container(
                    //               margin: EdgeInsets.only(
                    //                   top: 0, bottom: 0, left: 16),
                    //               child: Text(
                    //                 "Médecin",
                    //                 style: TextStyle(fontSize: 17),
                    //               ),
                    //             ),
                    //             Container(
                    //               margin: EdgeInsets.only(
                    //                   top: 0, bottom: 0, left: 16),
                    //               child: Text("Choisir un médecin"),
                    //             )
                    //           ]):
                    child: Container(
                      margin: EdgeInsets.only(top: 0, bottom: 16),
                      decoration: BoxDecoration(
                        //color: Color.fromARGB(255, 246, 246, 246),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        // border: Border.all(
                        //     color: DesignCourseAppTheme.nearlyBlue)
                      ),

                      width: size.width,

                      //height: 200,

                      child: Center(
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
                              child: medecin.nom.length >= 2
                                  ? Text(medecin.nom.substring(0, 2))
                                  : Text(medecin.nom),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              medecin.nom,
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(
                              flex: 26,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        )
      ],
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
                controller: lieuController,
                decoration: InputDecoration(
                  hintText: "Lieu",
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
        InkWell(
          onTap: () {
            DatePicker.showDateTimePicker(context,
                showTitleActions: true,
                minTime: DateTime(2023, 1, 1),
                maxTime: DateTime(2024, 12, 31), onConfirm: (date) {
              print(date);
              setState(() {
                heureController.text = '$date';
                a = Utils.formatDate(date);
                b = Utils.formatTime(date);
              });
            }, currentTime: DateTime.now(), locale: LocaleType.fr);
          },
          child: Row(
            children: [
              Container(
                height: 50,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16),
                width: 10,
                child: Icon(
                  IconData(0xe03a, fontFamily: 'MaterialIcons'),
                  color: Colors.blue,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 0, bottom: 0, left: 14),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text(
                            "Heure",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          child: Text('$a à $b'),
                        )
                      ])),
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
        child: Container(
          width: size.width - 60,
          height: 100,
          child: SingleChildScrollView(
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: remarqueController,
              decoration: InputDecoration(
                hintText: "Saisair les remarques",
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var changes = Provider.of<HomeProvider>(context, listen: true);
    a = Utils.formatDate(DateTime.parse(widget.rendezVous.heure));
    b = Utils.formatTime(DateTime.parse(widget.rendezVous.heure));
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  IconData(0xe16a, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                )),
            Spacer(),
            Text("Modifier rendez-vous",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Spacer(),
          ]),
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Color.fromARGB(255, 27, 62, 92),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
                style: ButtonStyle(
                  // minimumSize : MaterialStateProperty.all(Size(0,0)),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () async {
                  RendezVous rendezVous = RendezVous(
                    id: widget.rendezVous.id,
                    medecinId: medecin.id,
                    nom: nomController.text,
                    lieu: lieuController.text,
                    remarque: remarqueController.text,
                    heure: heureController.text,
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
                      print(heureController.text);
                      await rendezVousService.updateRendezVous(
                          rendezVous.toMap(), widget.rendezVous.id!);
                      changes.setChanges();
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
          section3(context),
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
                  child: Text("Supprimer Rendez-vous",
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
                                        await rendezVousService
                                            .deleteRendezVous(
                                                widget.rendezVous.id!);
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
          )
        ]),
      ),
    );
  }
}
