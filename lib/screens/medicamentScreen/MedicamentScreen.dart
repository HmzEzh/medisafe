import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:medisafe/models/Users/user.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/TrackerScreen.dart';
import 'package:medisafe/service/UserServices/UserService.dart';
import 'package:provider/provider.dart';

import 'home_design.dart';

class MedicamentScreen extends StatefulWidget {
  final int userId;

  MedicamentScreen({super.key, required this.userId});

  @override
  State<MedicamentScreen> createState() => _MedicamentScreenState();
}

class _MedicamentScreenState extends State<MedicamentScreen> {
  final UserService userService = UserService();

  late Future<User> _user;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _user = userService.getUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    var changes = Provider.of<HomeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
          title: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(90),
              onTap: (() {
                print("test");
              }),
              splashColor: Colors.white24,
              child: FutureBuilder<User>(
                future: _user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.toMap().isNotEmpty) {
                      final user = snapshot.data!;
                      Uint8List imageBytes = user.image;
                      return CircleAvatar(
                        radius: 20, // adjust the radius to fit your needs
                        backgroundImage: MemoryImage(imageBytes),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 20, // adjust the radius to fit your needs
                        backgroundImage:
                            AssetImage('assets/images/default.png'),
                      );
                    }
                  } else {
                    return CircleAvatar(
                      radius: 20, // adjust the radius to fit your needs
                      backgroundImage: AssetImage('assets/images/default.png'),
                    );
                  }
                },
              ),
            ),
          ),
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
                        builder: (BuildContext context) => TrackerScreen()),
                  );
                },
                child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons'),
                    color: Colors.white))
          ]),
      backgroundColor: Colors.white,
      body: DesignHomeScreen(),
    );
  }
}
