import 'package:flutter/material.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/Users/user.dart';

class EditAccountScreen extends StatefulWidget {
  final int userId;

  const EditAccountScreen({super.key, required this.userId});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
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
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  IconData(0xe16a, fontFamily: 'MaterialIcons'),
                  color: Color.fromARGB(255, 38, 58, 167),
                )),
            const Spacer(),
            const Text("Edit Profile",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 38, 58, 167))),
            const Spacer(),
          ]),
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: const Color.fromARGB(255, 246, 246, 246),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              style: ButtonStyle(
                // minimumSize : MaterialStateProperty.all(Size(0,0)),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: () async {
                //await userService.insertUser(user.toMap());
                //print(await userService.queryUsersCount());
                /*List<Map<String, dynamic>> user =
                    await userService.getUserById(1);
                print(user[0]);*/
              },
              child: const Icon(
                Icons.save,
                size: 20,
                color: Color.fromARGB(255, 38, 58, 167),
              ),
            )
          ]),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final user = snapshot.data!.first;
                return Text("Welcome, ${user['nom']}");
              } else {
                return const CircularProgressIndicator(
                  color: Color.fromARGB(255, 38, 58, 167),
                );
              }
            } else {
              return const CircularProgressIndicator(
                color: Color.fromARGB(255, 38, 58, 167),
              );
            }
          },
        ),
      ),
    );
  }
}
