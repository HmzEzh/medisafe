import 'package:flutter/material.dart';

class MedcinsInfosScreen extends StatefulWidget {
  const MedcinsInfosScreen({
    Key? key,
    required this.doctorId,
  }) : super(key: key);
  final int doctorId;
  @override
  State<MedcinsInfosScreen> createState() => _MedcinsInfosScreenState();
}

class _MedcinsInfosScreenState extends State<MedcinsInfosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                IconData(0xe16a, fontFamily: 'MaterialIcons'),
                color: Colors.blue,
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
                onPressed: () {},
                child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons')))
          ]),
      backgroundColor: Colors.white,
      body: Center(
        child: Text(widget.doctorId.toString()),
      ),
    );
  }
}
