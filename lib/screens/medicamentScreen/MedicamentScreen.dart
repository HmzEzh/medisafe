import 'package:flutter/material.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/TrackerScreen.dart';
import 'package:provider/provider.dart';

import 'home_design.dart';

class MedicamentScreen extends StatefulWidget {
  @override
  State<MedicamentScreen> createState() => _MedicamentScreenState();
}

class _MedicamentScreenState extends State<MedicamentScreen> {
  @override
  Widget build(BuildContext context) {
    var changes = Provider.of<HomeProvider>(context, listen: true);
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
                backgroundColor: Colors.white,
                child: const Text('HE'),
              )),
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
                  onPressed: () {
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              TrackerScreen()),
                    );
                  },
                  child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons'),color:Colors.white))
            ]),
      backgroundColor: Colors.white,
      body: DesignHomeScreen(),
    );
  }
}
