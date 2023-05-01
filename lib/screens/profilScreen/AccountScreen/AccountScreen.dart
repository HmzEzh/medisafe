import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/main.dart';
import 'package:medisafe/models/Users/user.dart';
import 'package:medisafe/screens/profilScreen/AccountScreen/EditAccountScreen.dart';
import 'package:medisafe/screens/profilScreen/ProfilScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:medisafe/service/UserServices/UserService.dart';

class AccountScreen extends StatefulWidget {
  final int userId;

  AccountScreen({super.key, required this.userId});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  //DatabaseHelper userService = DatabaseHelper.instance;
  UserService userService = UserService();
  //UserService userService = UserService();
  late Future<User> _user;

  @override
  void initState() {
    // TODO: implement initState
    //userService.init();
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
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const MyHomePage(
                        nbr: 3,
                        title: 'back to profil',
                      )),
            );
          },
        ),
        title: const Text(
          "Account",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        titleSpacing: 0.0,
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
                        EditAccountScreen(userId: widget.userId)),
              );
            },
            child: const Icon(
              Icons.edit_square,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<User>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.toMap().isNotEmpty) {
                var user = snapshot.data!;
                Uint8List imageBytes = user.image;
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
                                    child: Image.memory(imageBytes),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      // This function will be executed when the container is tapped
                                      //print(user['image']);

                                      final result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType
                                            .image, // Only show image files
                                      );
                                      if (result != null &&
                                          result.files.isNotEmpty) {
                                        // Handle the case where the user selected a file
                                        /*print(
                                            "the selected file is ${result.files.single.path}");*/
                                        final originalBytes = await File(
                                                result.files.single.path!)
                                            .readAsBytes();
                                        final fileBytes =
                                            await FlutterImageCompress
                                                .compressWithList(
                                          originalBytes,
                                          minHeight:
                                              1080, // set the minimum height of the compressed image
                                          minWidth:
                                              1080, // set the minimum width of the compressed image
                                          quality:
                                              50, // set the quality of the compressed image (0-100)
                                        );
                                        //print(fileBytes);
                                        Uint8List imageUint8List =
                                            Uint8List.fromList(fileBytes);
                                        userService.updateUserImage(
                                            widget.userId, fileBytes);
                                        //Uint8List bytes = await result.files[0].readAsBytes();
                                      } else {
                                        // Handle the case where the user cancelled the file selection operation
                                        print(
                                            "File selection cancelled by user");
                                      }

                                      /*final ByteData imageData =
                                          await rootBundle
                                              .load('assets/images/avatar.jpg');
                                      final Uint8List imageBytes2 =
                                          imageData.buffer.asUint8List();

                                      userService.updateUserImage(
                                          widget.userId, imageBytes2);*/
                                    },
                                    child: Container(
                                      width: waille * 0.09,
                                      height: waille * 0.09,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.black,
                                      ),
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.white,
                                        size: waille * 0.06,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: haille * 0.02),
                              child: Text(
                                "${user.prenom} ${user.nom}",
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
                                  "${user.poids} Kg",
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
                                  "${user.taille} cm",
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
                                        "${user.email}",
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
                                        "${user.tele}",
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
                                        "${user.address}",
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
                                        "${user.blood}",
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
                                        "Gender : ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${user.gender}",
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
