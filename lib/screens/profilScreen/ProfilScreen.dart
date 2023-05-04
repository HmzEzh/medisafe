import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medisafe/screens/profilScreen/rendezVousScreen/RendezVousListScreen.dart';
import 'package:medisafe/screens/profilScreen/reportMedicaments/reportMedicaments.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:share/share.dart';
import '../../controller/user/logOutController.dart';
import '../../service/serviceLocator.dart';
import '../loginScreen.dart';
import 'MedecinScreen/MedcinsListScreen.dart';
import 'AccountScreen/AccountScreen.dart';
import 'package:medisafe/service/UserServices/UserService.dart';
import 'package:medisafe/models/Users/user.dart';
import '../introduction_animation/introduction_animation_screen.dart';
import 'TrackerScreen/TrackerScreen.dart';

class ProfilScreen extends StatefulWidget {
  final int userId;

  ProfilScreen({super.key, required this.userId});

  @override
  State<ProfilScreen> createState() => _ProfilScreen();
}

class _ProfilScreen extends State<ProfilScreen> {
  final UserService userService = UserService();
  final logoutController = getIt<LogoutController>();

  late Future<User> _user;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _user = userService.getUserById(widget.userId);
  }

  deleteToken() async {
    await storage.delete(key: 'token');
  }

  Future logout() async {
    Navigator.pop(context);
    showDialog(
        barrierDismissible: false,
        barrierColor: Color.fromARGB(0, 0, 0, 0),
        context: context,
        builder: (BuildContext context) => WillPopScope(
              onWillPop: () async => false,
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
            ));
    try {
      bool response = await logoutController
          .logout(await PlatformDeviceId.getDeviceId ?? "");
      userService.deleteUser(1);
      //userService.truncateTable();
      print(
          "deleted user number 1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(await PlatformDeviceId.getDeviceId ?? "");
      if (response) {
        deleteToken();
        Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      } else {
        Navigator.pop(context);
      }
      //TODO: delete all data in all tabels
      // Provider.of<CollectionProvider>(context, listen: false).deleteData();
      // Provider.of<UserProvider>(context, listen: false).deleteData();
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                buttonPadding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
                title: const Text(
                  'La connexion a échoué',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                      child: Text(
                        e.toString(),
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
                              top: BorderSide(color: Colors.grey),
                            )),
                            height: 50,
                            child: const Center(
                              child: Text("OK",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ));
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Error: ${e.toString()}'),
      //   backgroundColor: Colors.red.shade300,
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double waille = MediaQuery.of(context).size.width;
    final double haille = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
          title: const Text(
            "Profil",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
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
                  logout();
                  print("logout");
                },
                child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons'),
                    color: Colors.white))
          ]),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<User>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.toMap().isNotEmpty) {
                final user = snapshot.data!;
                Uint8List imageBytes = user.image;
                return Center(
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => AccountScreen(
                                userId: 1,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(62, 117, 117, 117),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(1, 4))
                              ]),
                          margin: EdgeInsets.fromLTRB(waille * 0.03,
                              haille * 0.02, waille * 0.03, haille * 0.02),
                          padding: const EdgeInsets.all(5),
                          width: waille,
                          height: haille * 0.15,
                          child: Row(
                            children: [
                              Container(
                                height: haille * 0.12,
                                width: waille * 0.25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: CircleAvatar(
                                  radius:
                                      50, // adjust the radius to fit your needs
                                  backgroundImage: MemoryImage(imageBytes),
                                ),
                              ),
                              Container(
                                height: haille * 0.12,
                                width: waille * 0.58,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${user.prenom} ${user.nom}",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 61, 77, 85),
                                      ),
                                    ),
                                    Text(
                                      "nom, prenom, age, poids...",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 102, 120, 129),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: haille * 0.12,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.blueGrey,
                                  size: haille * 0.023,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(waille * 0.03,
                            haille * 0.01, waille * 0.03, haille * 0.02),
                        padding: const EdgeInsets.all(10),
                        height: haille * 0.33,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(62, 117, 117, 117),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(1, 4)),
                            ]),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          TrackerScreen()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Color.fromARGB(255, 81, 93, 99),
                                    width: 0.5,
                                  )),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Icon(
                                        Icons.area_chart_outlined,
                                        size: 20,
                                        color: Color.fromARGB(255, 81, 93, 99),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          waille * 0.02, 0, 0, 0),
                                      width: waille * 0.71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Text(
                                        "Trackers",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 81, 93, 99),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.blueGrey,
                                        size: haille * 0.023,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          RendezVousListScreen()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Color.fromARGB(255, 81, 93, 99),
                                    width: 0.5,
                                  )),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Icon(
                                        Icons.calendar_today,
                                        size: 20,
                                        color: Color.fromARGB(255, 81, 93, 99),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          waille * 0.02, 0, 0, 0),
                                      width: waille * 0.71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Text(
                                        "Rendez-vous",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 81, 93, 99),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.blueGrey,
                                        size: haille * 0.023,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          MedcinsListScreen()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Color.fromARGB(255, 81, 93, 99),
                                    width: 0.5,
                                  )),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Icon(
                                        Icons.contact_mail_outlined,
                                        size: 20,
                                        color: Color.fromARGB(255, 81, 93, 99),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          waille * 0.02, 0, 0, 0),
                                      width: waille * 0.71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Text(
                                        "Doctors",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 81, 93, 99),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.blueGrey,
                                        size: haille * 0.023,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          ReportMedicamentsScreen()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.transparent)),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent)),
                                      child: const Icon(
                                        Icons.analytics_outlined,
                                        size: 20,
                                        color: Color.fromARGB(255, 81, 93, 99),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          waille * 0.02, 0, 0, 0),
                                      width: waille * 0.71,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent)),
                                      child: const Text(
                                        "Report",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 81, 93, 99),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.blueGrey,
                                        size: haille * 0.023,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(waille * 0.03,
                            haille * 0.01, waille * 0.03, haille * 0.02),
                        padding: const EdgeInsets.all(10),
                        height: haille * 0.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(62, 117, 117, 117),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(1, 4)),
                            ]),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          IntroductionAnimationScreen()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Color.fromARGB(255, 102, 120, 129),
                                    width: 0.5,
                                  )),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Icon(
                                        Icons.settings_outlined,
                                        size: 20,
                                        color: Color.fromARGB(255, 81, 93, 99),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          waille * 0.02, 0, 0, 0),
                                      width: waille * 0.71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Text(
                                        "Settings",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 81, 93, 99)),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.blueGrey,
                                        size: haille * 0.023,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Share.share('Check out this cool app!');
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, 0, haille * 0.015),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Color.fromARGB(255, 102, 120, 129),
                                    width: 0.5,
                                  )),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Icon(
                                        Icons.share,
                                        size: 20,
                                        color: Color.fromARGB(255, 81, 93, 99),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          waille * 0.02, 0, 0, 0),
                                      width: waille * 0.71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Text(
                                        "Share",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 81, 93, 99)),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.blueGrey,
                                        size: haille * 0.023,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 60),
                                          buttonPadding: EdgeInsets.zero,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0.0, 24.0, 0.0, 0.0),
                                          title: const Text(
                                            'Déconnexion',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 200,
                                                margin: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 24),
                                                child: const Text(
                                                  "Voulez-vous vraiment vous déconnecter ?",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: InkWell(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                              right: BorderSide(
                                                                  color: Colors
                                                                      .grey))),
                                                      height: 50,
                                                      child: const Center(
                                                        child: Text("Annuler",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                    ),
                                                  )),
                                                  Expanded(
                                                      child: InkWell(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                    onTap: () {
                                                      logout();
                                                      /*userService
                                                          .truncateTable();*/
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              border: Border(
                                                        top: BorderSide(
                                                            color: Colors.grey),
                                                      )),
                                                      height: 50,
                                                      child: const Center(
                                                        child: Text(
                                                          "Déconnexion",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
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
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.transparent)),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Icon(
                                        Icons.logout,
                                        size: 20,
                                        color: Color.fromARGB(255, 81, 93, 99),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          waille * 0.02, 0, 0, 0),
                                      width: waille * 0.71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: const Text(
                                        "Logout",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 81, 93, 99),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.blueGrey,
                                        size: haille * 0.023,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
