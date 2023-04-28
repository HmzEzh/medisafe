import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medisafe/models/Users/user.dart';
import 'package:medisafe/service/UserServices/UserService.dart';

class RecomScreen extends StatefulWidget {
  final int userId;

  RecomScreen({Key? key, required this.userId}) : super(key: key);
  @override
  State<RecomScreen> createState() => _RecomScreenState();
}

class _RecomScreenState extends State<RecomScreen> {
  UserService userService = UserService();
  late Future<User> _user;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _user = userService.getUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: FutureBuilder<User>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.toMap().isNotEmpty) {
                final user = snapshot.data!;
                Uint8List imageBytes = user.image;
                return AppBar(
                    title: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(90),
                        onTap: (() {
                          print("test");
                        }),
                        splashColor: Colors.white24,
                        child: CircleAvatar(
                          radius: 20, // adjust the radius to fit your needs
                          backgroundImage: MemoryImage(imageBytes),
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
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            splashFactory: NoSplash.splashFactory,
                          ),
                          onPressed: () async {
                            print("test");
                            final ByteData imageData = await rootBundle
                                .load('assets/images/default.png');
                            final Uint8List imageBytes2 =
                                imageData.buffer.asUint8List();

                            userService.updateUserImage(1, imageBytes2);
                          },
                          child: Icon(
                              IconData(0xe047, fontFamily: 'MaterialIcons'),
                              color: Colors.white))
                    ]);
              } else {
                return const CircularProgressIndicator();
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      body: const Center(child: Text("recomendation")),
    );
  }
}
