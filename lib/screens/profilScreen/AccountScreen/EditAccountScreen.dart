import 'package:flutter/material.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/Users/user.dart';
import 'package:medisafe/screens/profilScreen/AccountScreen/AccountScreen.dart';
import 'package:medisafe/service/UserServices/UserService.dart';

class EditAccountScreen extends StatefulWidget {
  final int userId;

  const EditAccountScreen({super.key, required this.userId});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController naissanceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController tailleController = TextEditingController();
  TextEditingController poidsController = TextEditingController();
  TextEditingController teleController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserService userService2 = UserService();
  DatabaseHelper userService = DatabaseHelper.instance;
  late Future<List<Map<String, dynamic>>> _user;

  @override
  void initState() {
    // TODO: implement initState
    userService.init();
    super.initState();
    _user = userService.getUserById(widget.userId);
  }

  Widget person(BuildContext context, Map<String, dynamic> user) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),

        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                controller: nomController,
                decoration: InputDecoration(
                  hintText: 'First name',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.person_outline,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                controller: prenomController,
                decoration: InputDecoration(
                  hintText: 'Last name',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget age(BuildContext context, Map<String, dynamic> user) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                keyboardType: TextInputType.streetAddress,
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.event,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                controller: naissanceController,
                decoration: InputDecoration(
                  hintText: 'Birthdate',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.phone_outlined,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: teleController,
                decoration: InputDecoration(
                  hintText: 'Phone number',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget body(BuildContext context, Map<String, dynamic> user) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.straighten,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: tailleController,
                decoration: InputDecoration(
                  hintText: 'Height (cm)',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.monitor_weight_outlined,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: poidsController,
                decoration: InputDecoration(
                  hintText: 'Weight (Kg)',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.bloodtype_outlined,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                controller: bloodController,
                decoration: InputDecoration(
                  hintText: 'Blood type',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
            InkWell(
                onTap: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            AccountScreen(userId: widget.userId)),
                  );
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
                print(nomController.text);
                User update = User(
                    id: widget.userId,
                    nom: nomController.text,
                    prenom: prenomController.text,
                    date_naissance: naissanceController.text,
                    address: addressController.text,
                    age: int.parse(ageController.text),
                    taille: int.parse(tailleController.text),
                    poids: int.parse(poidsController.text),
                    email: emailController.text,
                    password: passwordController.text,
                    tele: teleController.text,
                    blood: bloodController.text);

                userService2.updateUser(update, widget.userId);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Container(
                      padding: EdgeInsets.only(top: 0, bottom: 2),
                      child: Text(
                        "Enregistré",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color.fromARGB(255, 75, 138, 220),
                  margin: EdgeInsets.only(bottom: 20, left: 25, right: 25),
                ));
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
                nomController = TextEditingController(text: user['nom']);
                prenomController = TextEditingController(text: user['prenom']);
                naissanceController =
                    TextEditingController(text: user['date_naissance']);
                addressController =
                    TextEditingController(text: user['address']);
                tailleController =
                    TextEditingController(text: user['taille'].toString());
                poidsController =
                    TextEditingController(text: user['poids'].toString());
                teleController = TextEditingController(text: user['tele']);
                bloodController = TextEditingController(text: user['blood']);
                ageController =
                    TextEditingController(text: user['age'].toString());
                emailController = TextEditingController(text: user['email']);
                passwordController =
                    TextEditingController(text: user['password']);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      person(context, user),
                      age(context, user),
                      body(context, user)
                    ],
                  ),
                );
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
