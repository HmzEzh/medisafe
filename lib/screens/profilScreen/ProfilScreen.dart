import 'package:flutter/material.dart';
import 'MedecinScreen/MedcinsListScreen.dart';
import 'AccountScreen/AccountScreen.dart';
import '../introduction_animation/introduction_animation_screen.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double waille = MediaQuery.of(context).size.width;
    final double haille = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
            "Profil",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 104, 118, 124),
            ),
          ),
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
                  print("test");
                },
                child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons')))
          ]),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => AccountScreen()),
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
                margin: EdgeInsets.fromLTRB(
                    waille * 0.03, haille * 0.02, waille * 0.03, haille * 0.02),
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
                      child: InkWell(
                          borderRadius: BorderRadius.circular(90),
                          onTap: (() {
                            debugPrint('test');
                          }),
                          splashColor: Colors.white24,
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Color.fromARGB(255, 38, 58, 167),
                            child: Text(
                              'AM',
                              style: TextStyle(fontSize: 30),
                            ),
                          )),
                    ),
                    Container(
                      height: haille * 0.12,
                      width: waille * 0.58,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Amine Mhani",
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
                              color: Color.fromARGB(255, 102, 120, 129),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: haille * 0.12,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueGrey,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  waille * 0.03, haille * 0.01, waille * 0.03, haille * 0.02),
              padding: const EdgeInsets.all(10),
              height: 270,
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
              child: ListView(
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
                      margin: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
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
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.settings_outlined,
                              size: 20,
                              color: Color.fromARGB(255, 81, 93, 99),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(waille * 0.02, 0, 0, 0),
                            width: waille * 0.71,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Text(
                              "Settings",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 81, 93, 99)),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blueGrey,
                              size: 15,
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
                      margin: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
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
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(waille * 0.02, 0, 0, 0),
                            width: waille * 0.71,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Text(
                              "Search",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 81, 93, 99),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blueGrey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
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
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.share,
                              size: 20,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(waille * 0.02, 0, 0, 0),
                            width: waille * 0.71,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Text(
                              "Share",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 81, 93, 99),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blueGrey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
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
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.contact_mail_outlined,
                              size: 20,
                              color: Color.fromARGB(255, 81, 93, 99),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(waille * 0.02, 0, 0, 0),
                            width: waille * 0.71,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Text(
                              "Contacts",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 81, 93, 99),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blueGrey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, haille * 0.015),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.analytics_outlined,
                              size: 20,
                              color: Color.fromARGB(255, 81, 93, 99),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(waille * 0.02, 0, 0, 0),
                            width: waille * 0.71,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Text(
                              "Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 81, 93, 99),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blueGrey,
                              size: 15,
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
      ),
    );
  }
}
