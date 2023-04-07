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
            child: const Icon(
              Icons.edit_square,
              size: 20,
              color: Color.fromARGB(255, 38, 58, 167),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          /// -- IMAGE
          Stack(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red),
                  child: const Icon(
                    Icons.abc,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
