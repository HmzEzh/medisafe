import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:medisafe/controller/user/UpdateUserController.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/Users/user.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/profilScreen/AccountScreen/AccountScreen.dart';
import 'package:medisafe/service/UserServices/UserService.dart';
import 'package:provider/provider.dart';

class EditAccountScreen extends StatefulWidget {
  final int userId;

  const EditAccountScreen({super.key, required this.userId});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController naissanceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController tailleController = TextEditingController();
  TextEditingController poidsController = TextEditingController();
  TextEditingController teleController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  late Uint8List image;

  late int numberOfDaysInMonth;

  //List<String> PickerData = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  //DatabaseHelper userService = DatabaseHelper.instance;
  UserService userService = UserService();
  UpdateUserController updateUserController = UpdateUserController();

  late Future<User> _user;

  @override
  void initState() {
    // TODO: implement initState
    //userService.init();
    super.initState();
    numberOfDaysInMonth =
        getTheNumberOfDaysInMonth(DateTime.now().year, DateTime.now().month);
    _user = userService.getUserById(widget.userId);
  }

  int getTheNumberOfDaysInMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    // Add one month to get the first day of the next month
    DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
    // Subtract one day from the first day of the next month to get the last day of the current month
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    // Get the day of the month for the last day of the current month
    int numberOfDaysInMonth = lastDayOfMonth.day;
    print(numberOfDaysInMonth); // Output: 31 (for March 2023)
    return numberOfDaysInMonth;
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = (currentDate.difference(birthDate).inDays / 365).round();
    return age;
  }

  final ScrollController _controller = ScrollController();
  bool _init = true;
  void _animateToIndex(int index, double _width) {
    _controller.animateTo(
      (index - 1) * _width,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget person(BuildContext context, User user) {
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
      child: Column(
        children: [
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
        ],
      ),
    );
  }

  Widget age(BuildContext context, User user) {
    var selectedDay = Provider.of<HomeProvider>(context, listen: true);
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
              margin: EdgeInsets.only(left: 16, right: 25),
              width: 10,
              child: Icon(
                Icons.event,
                color: Colors.blue,
              ),
            ),
            Container(
                width: size.width - 67,
                child: TextFormField(
                  controller: naissanceController,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(naissanceController.text),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      naissanceController.text = formattedDate;
                    }
                  },
                )),
          ],
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
                Icons.badge,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: cinController,
                decoration: InputDecoration(
                  hintText: 'CIN',
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

  Widget body(BuildContext context, User user) {
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
                Icons.man,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                controller: genderController,
                decoration: InputDecoration(
                  hintText: 'Gender',
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
                  Navigator.pop(context);
                },
                child: const Icon(
                  IconData(0xe16a, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                )),
            const Spacer(),
            const Text("Modifier Profil",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const Spacer(),
          ]),
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Color.fromARGB(255, 27, 62, 92),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              style: ButtonStyle(
                // minimumSize : MaterialStateProperty.all(Size(0,0)),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: () async {
                User update = User(
                    id: widget.userId,
                    nom: nomController.text == "" ? "-" : nomController.text,
                    prenom: prenomController.text == ""
                        ? "-"
                        : prenomController.text,
                    cin: cinController.text == "" ? "-" : cinController.text,
                    date_naissance: naissanceController.text == ""
                        ? "2020-01-01"
                        : naissanceController.text,
                    address: addressController.text == ""
                        ? "-"
                        : addressController.text,
                    taille: tailleController.text == ""
                        ? "0"
                        : tailleController.text,
                    poids:
                        poidsController.text == "" ? "0" : poidsController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    tele: teleController.text == "" ? "-" : teleController.text,
                    blood:
                        bloodController.text == "" ? "-" : bloodController.text,
                    gender: genderController.text == ""
                        ? "-"
                        : genderController.text,
                    image: image);

                print(update.toMap());

                userService.updateUser(update, widget.userId);
                update = userService.encryptUser(update);
                updateUserController.updateUserInfo(update.toMap());

                Navigator.pop(context);
              },
              child: const Icon(
                Icons.save,
                size: 20,
                color: Colors.white,
              ),
            )
          ]),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.toMap().isNotEmpty) {
                final user = snapshot.data!;
                nomController = TextEditingController(text: user.nom);
                prenomController = TextEditingController(text: user.prenom);
                cinController = TextEditingController(text: user.cin);
                naissanceController =
                    TextEditingController(text: user.date_naissance);
                addressController = TextEditingController(text: user.address);
                tailleController =
                    TextEditingController(text: user.taille.toString());
                poidsController =
                    TextEditingController(text: user.poids.toString());
                teleController = TextEditingController(text: user.tele);
                bloodController = TextEditingController(text: user.blood);
                emailController = TextEditingController(text: user.email);
                passwordController = TextEditingController(text: user.password);
                genderController = TextEditingController(text: user.gender);

                image = user.image;

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
