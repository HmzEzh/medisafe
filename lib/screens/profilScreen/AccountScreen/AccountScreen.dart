import 'package:flutter/material.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/Users/user.dart';
import 'package:medisafe/screens/profilScreen/AccountScreen/EditAccountScreen.dart';
import 'package:medisafe/screens/profilScreen/ProfilScreen.dart';

class AccountScreen extends StatefulWidget {
  final int userId;

  AccountScreen({super.key, required this.userId});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  DatabaseHelper userService = DatabaseHelper.instance;
  late Future<List<Map<String, dynamic>>> _user;

  @override
  void initState() {
    // TODO: implement initState
    userService.init();
    super.initState();
    _user = userService.getUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final double waille = MediaQuery.of(context).size.width;
    final double haille = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 38, 58, 167),
          ),
          onPressed: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      ProfilScreen(userId: widget.userId)),
            );
          },
        ),
        title: const Text(
          "Account",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 38, 58, 167),
          ),
        ),
        titleSpacing: 0.0,
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
                        EditAccountScreen(userId: widget.userId)),
              );
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
        alignment: Alignment.center,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final user = snapshot.data!.first;
                return Container(
                  color: Colors.blue[100],
                  child: ListView(
                    children: [
                      /// -- IMAGE
                      Container(
                        padding: EdgeInsets.only(top: haille * 0.03),
                        height: haille * 0.35,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Colors.white, // set border color here
                                      width: 1.0,
                                      // set border width here
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  width: waille * 0.32,
                                  height: waille * 0.32,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:
                                        Image.asset('assets/images/avatar.jpg'),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: waille * 0.09,
                                    height: waille * 0.09,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                              child: Text(
                                "${user['prenom']} ${user['nom']}",
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${user['poids']} Kg",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 20,
                                  width: 2,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${user['taille']} cm",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(waille * 0.07,
                                haille * 0.03, waille * 0.07, haille * 0.03),
                            height: haille * 0.8,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.all(haille * 0.01)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: const Text(
                                        "Email : ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${user['email']}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 83, 82, 82),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                Padding(padding: EdgeInsets.all(haille * 0.01)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: const Text(
                                        "Phone number : ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${user['tele']}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 83, 82, 82),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                Padding(padding: EdgeInsets.all(haille * 0.01)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: const Text(
                                        "Address : ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${user['address']}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 83, 82, 82),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                Padding(padding: EdgeInsets.all(haille * 0.01)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: const Text(
                                        "Blood Type : ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${user['blood']}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 83, 82, 82),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
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
