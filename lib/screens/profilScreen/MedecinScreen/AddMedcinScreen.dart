import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/MedecinController.dart';
import '../../../helpers/DatabaseHelper.dart';
import '../../../models/medcin.dart';
import '../../../provider/HomeProvider.dart';
import '../../../service/serviceLocator.dart';
import 'MedcinsListScreen.dart';

class AddMedcinScreen extends StatefulWidget {
  const AddMedcinScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<AddMedcinScreen> createState() => _AddMedcinScreenState();
}

class _AddMedcinScreenState extends State<AddMedcinScreen> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController specialiteController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bureauController = TextEditingController();
  final TextEditingController teleController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  DatabaseHelper medcinService = DatabaseHelper.instance;
  final medecinController = getIt<MedecinController>();

  @override
  void initState() {
    // TODO: implement initState
    medcinService.init();
    super.initState();
  }

  Widget section1(BuildContext context) {
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
        Container(
          //color: Color.fromARGB(255, 246, 246, 246),
          child: TextFormField(
            controller: specialiteController,
            decoration: InputDecoration(
              hintText: "Spécialité",
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
                  hintText: "doctor@mail.com",
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
                  hintText: "Numéro du bureau",
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
                  hintText: "Numéro de portable",
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
                  hintText: "Adresse",
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

  @override
  Widget build(BuildContext context) {
    var changes = Provider.of<HomeProvider>(context, listen: true);
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
            Text("Ajouter un médcin",
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
                  Medcin medcin = Medcin.az(
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
                     try{
                       int id = await medcinService.insertMedecin(medcin.toMap());
                        medcin.id = id;
                        medecinController.createMedecin(medcin, 1);

                     }catch(e){

                     }
                      

                      //print(await medcinService.queryRowCount());
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      changes.setChanges();
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
                  "save",
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
        ]),
      ),
    );
  }
}
