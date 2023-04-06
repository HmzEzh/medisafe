import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
            "Account",
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
    );
  }
}
