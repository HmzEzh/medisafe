import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';

class RecomScreen extends StatelessWidget {
  DatabaseHelper userService = DatabaseHelper.instance;
  @override
  void initState() {
    // TODO: implement initState
    userService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(0, 0)),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: () async {
                print("test");
              },
              child: CircleAvatar(
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
                onPressed: () async {
                  print("test");
                  final ByteData imageData =
                      await rootBundle.load('assets/images/default.png');
                  final Uint8List imageBytes2 = imageData.buffer.asUint8List();

                  userService.updateUserImage(1, imageBytes2);
                },
                child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons')))
          ]),
      body: const Center(child: Text("recomendation")),
    );
  }
}
