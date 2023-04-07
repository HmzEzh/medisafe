import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final double waille = MediaQuery.of(context).size.width;
    final double haille = MediaQuery.of(context).size.height;

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
      body: Container(
        color: Color.fromARGB(218, 38, 57, 167),
        child: Column(
          children: [
            /// -- IMAGE
            Container(
              padding: EdgeInsets.only(top: haille * 0.03),
              height: haille * 0.3,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // set border color here
                            width: 1.0,
                            // set border width here
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: waille * 0.32,
                        height: waille * 0.32,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/images/avatar.jpg'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: waille * 0.09,
                          height: waille * 0.09,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black),
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: waille * 0.06,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: haille * 0.02),
                    child: const Text(
                      "Amine Mhani",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  height: haille * 0.575,
                  width: waille,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                        bottom: Radius.circular(0),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(62, 117, 117, 117),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(1, 4)),
                      ]),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text("description : "),
                          ),
                          Container(
                            child: Text("the text of the description."),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
