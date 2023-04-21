import 'package:flutter/material.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/TrackerScreen.dart';

import 'home_design.dart';

class MedicamentScreen extends StatefulWidget {
  @override
  State<MedicamentScreen> createState() => _MedicamentScreenState();
}

class _MedicamentScreenState extends State<MedicamentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextButton(
                  style: ButtonStyle(
                     minimumSize : MaterialStateProperty.all(Size(0,0)),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    print("test");
                  },
                  child:CircleAvatar(
                backgroundColor: Color.fromARGB(255, 38, 58, 167),
                child: const Text('HE'),
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
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              TrackerScreen()),
                    );
                  },
                  child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons')))
            ]),
      backgroundColor: Colors.white,
      body: DesignHomeScreen(),
    );
  }
}
