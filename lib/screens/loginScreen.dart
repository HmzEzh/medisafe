import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/service/UserServices/UserService.dart';

import '../controller/user/loginController.dart';
import '../helpers/MyEncryptionDecryption.dart';
import '../main.dart';
import '../models/Rappel.dart';
import '../models/Users/user.dart';
import '../network/dioClient.dart';
import '../network/dioException.dart';
import '../service/serviceLocator.dart';
import 'createNewUser.dart';
import 'validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formForRestPassword = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailForRestPasswController =
      TextEditingController();
  bool _showPassword = false;
  bool passwdListner = false;
  bool emailListner = false;

  final loginController = getIt<LoginController>();
  final DatabaseHelper database = DatabaseHelper.instance;

  UserService userService = UserService();

  // final resetpassword = getIt.get<DioClient>();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          useRootNavigator: false,
          barrierDismissible: false,
          barrierColor: Color.fromARGB(0, 0, 0, 0),
          context: context,
          builder: (BuildContext context) => WillPopScope(
                onWillPop: () async => false,
                child: Center(
                    child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: Color.fromARGB(36, 81, 86, 90)),
                  child: Center(
                      child: CupertinoActivityIndicator(
                    radius: 20,
                  )),
                )),
              ));
      try {
        //TODO:
        dbHelper.setPasse(passwordController.text);
        //MyEncryptionDecryption.passe = passwordController.text;
        Map _user = await loginController.login(
            MyEncryptionDecryption.encryptAES(emailController.text.trim())
                .base64,
            MyEncryptionDecryption.encryptAES(passwordController.text.trim())
                .base64);

        /*Map _user = await loginController.login(
            emailController.text, passwordController.text);*/

        print(_user);
        print("the nom of the user is ${_user["nom"]}");
        print("the prenom of the user is ${_user["prenom"]}");
        print("the cin of the user is ${_user["cin"]}");
        print("the naissance of the user is ${_user["date_naissance"]}");
        print("the address of the user is ${_user["address"]}");
        print("the taille of the user is ${_user["taille"]}");
        print("the poids of the user is ${_user["poids"]}");
        print("the email of the user is ${_user["email"]}");
        print("the password of the user is ${_user["password"]}");
        print("the tele of the user is ${_user["tele"]}");
        print("the blood of the user is ${_user["blood"]}");
        print("the gender of the user is ${_user["gender"]}");

        //User user = User.fromMap(_user);
        /*User user = User.create(
            nom: _user["nom"],
            prenom: _user["prenom"],
            cin: _user["cin"],
            date_naissance: _user["date_naissance"],
            address: _user["address"],
            taille: double.parse(_user["taille"]).truncate(),
            poids: double.parse(_user["poids"]).truncate(),
            email: _user["email"],
            password: _user["password"],
            tele: _user["tele"],
            blood: _user["blood"],
            gender: _user["gender"],
            image: base64.decode(_user["image"]));*/

        User user = User.fromJson(_user);

        print(user.toMap());

        user = userService.decryptUser(user);
        print("The user id before is ${user.id}");
        user.id = 1;
        print("The user id after is ${user.id}");
        print(user.toMap());

        //User enc = userService.encryptUser(user);
        //User dec = userService.decryptUser(enc);

        //print(enc.toMap());
        /*print(dec.toMap());*/

        userService.insertUser(user);
        /*var count = userService.getUsersCount(); 
        print("the number of users is ${count}");*/
        //print(base64.decode(_user["image"]));
        //print(user.toMap());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);

        var motdepasse = await dbHelper.getUsers();
        var passe = motdepasse[0]["password"];
        Rappel rap = Rappel();
        rap.motDePasse = passe;
        MyEncryptionDecryption();
        database.insertAll();
      } on DioExceptions catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  buttonPadding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  contentPadding:
                      const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
                  title: const Text(
                    'La connexion a échoué',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 24),
                        child: Text(
                          e.message,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                            ),
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                top: BorderSide(color: Colors.grey),
                              )),
                              height: 50,
                              child: const Center(
                                child: Text("OK",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text('Error: ${e.toString()}'),
        //   backgroundColor: Colors.red.shade300,
        // ));
      }
    }
  }

  Future<void> resetPassword() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              buttonPadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              // title: const Text(
              //   'La connexion a échoué',
              //   textAlign: TextAlign.center,
              //   style:
              //       TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              // ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 8, top: 8),
                      child: Text("Recherch de votre compte",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 246, 246, 246)),
                      child: Form(
                          key: _formForRestPassword,
                          child: TextFormField(
                            controller: emailForRestPasswController,
                            validator: (value) {
                              return Validator.validateEmail(value ?? "");
                            },
                            decoration: InputDecoration(
                              hintText: "Adresse e-mail ",
                              isDense: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.grey),
                                    right: BorderSide(color: Colors.grey))),
                            height: 50,
                            child: const Center(
                              child: Text("Annuler",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                          onTap: () async {
                            if (emailForRestPasswController.text.isNotEmpty) {
                              // Navigator.pop(context);
                              showDialog(
                                  barrierDismissible: false,
                                  barrierColor: Color.fromARGB(0, 0, 0, 0),
                                  context: context,
                                  builder: (BuildContext context) =>
                                      WillPopScope(
                                        onWillPop: () async => false,
                                        child: Center(
                                            child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              color: Color.fromARGB(
                                                  36, 81, 86, 90)),
                                          child: Center(
                                              child: CupertinoActivityIndicator(
                                            radius: 20,
                                          )),
                                        )),
                                      ));
                              try {
                                //TODO:
                                // dynamic response =
                                //     await resetpassword.resetPassword(
                                //         emailForRestPasswController.text,
                                //         (await PlatformDeviceId.getDeviceId ??
                                //             ""));
                                String email = emailForRestPasswController.text;
                                print(email);
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 60),
                                          buttonPadding: EdgeInsets.zero,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0.0, 24.0, 0.0, 0.0),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    bottom: 24),
                                                child: Text(
                                                  'Nous venons d\'envoyer un e-mail de réinitialisation de mot de passe à  $email. quand vous recevez cet e-mail, cliquez sur le lien qu\'il contient pour réinitialiser votre mot de passe',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: InkWell(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              border: Border(
                                                        top: BorderSide(
                                                            color: Colors.grey),
                                                      )),
                                                      height: 50,
                                                      child: const Center(
                                                        child: Text("OK",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                    ),
                                                  ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                                emailForRestPasswController.clear();
                              } catch (e) {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 70),
                                          buttonPadding: EdgeInsets.zero,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0.0, 24.0, 0.0, 0.0),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 16),
                                                child: Text(
                                                  "Erreur",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    bottom: 24),
                                                child: Text(
                                                  "Une erreur s'est produite lors de la réinitialisation de votre mot de passe.\nVeuillez réessayer",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: InkWell(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              border: Border(
                                                        top: BorderSide(
                                                            color: Colors.grey),
                                                      )),
                                                      height: 50,
                                                      child: const Center(
                                                        child: Text("OK",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                    ),
                                                  ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                //   content: Text('Error: ${e.toString()}'),
                                //   backgroundColor: Colors.red.shade300,
                                // ));
                              }
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(color: Colors.grey),
                            )),
                            height: 50,
                            child: const Center(
                              child: Text("Continuer",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          backgroundColor: Color.fromARGB(255, 27, 62, 92),
          title: TextButton(
              style: ButtonStyle(
                // minimumSize : MaterialStateProperty.all(Size(0,0)),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: () {
                //TODO:
              },
              child: Text(
                "S'inscrire plus tard",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
              )),
        ),
        body: Form(
          key: _formKey,
          child: Stack(children: [
            SizedBox(
              width: size.width,
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: size.height * 0.04),
                        // Center(
                        //   child: Container(
                        //     margin: const EdgeInsets.only(
                        //       bottom: 8,
                        //     ),
                        //     width: 128,
                        //     child: Image(
                        //         image: AssetImage("assets/images/logo_.png")),
                        //   ),
                        // ),
                        // SizedBox(height: size.height * 0.08),
                        Center(
                            child: Text(
                          "Medisafe",
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 41, 101, 117)),
                        )),
                        SizedBox(height: size.height * 0.01),
                        Center(
                          child: Text(
                            "Connectez-vous a votre compte",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.06),
                        TextFormField(
                          onChanged: ((value) {
                            if (value.length != 0) {
                              setState(() {
                                emailListner = true;
                              });
                            } else {
                              setState(() {
                                emailListner = false;
                              });
                            }
                          }),
                          // initialValue: 'yazid.slila01@gmail.com',
                          controller: emailController,
                          validator: (value) {
                            return Validator.validateEmail(value ?? "");
                          },
                          decoration: InputDecoration(
                            hintText: "Adress e-mail (requis)",
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFormField(
                          onChanged: ((value) {
                            if (value.length != 0) {
                              setState(() {
                                passwdListner = true;
                              });
                            } else {
                              setState(() {
                                passwdListner = false;
                              });
                            }
                          }),
                          // initialValue: "y.okg123",
                          obscureText: _showPassword,
                          controller: passwordController,
                          validator: (value) {
                            return Validator.validatePassword(value ?? "");
                          },
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() => _showPassword = !_showPassword);
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Mot de passe (requis)",
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.all(Size(0, 0)),
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                onPressed: () => resetPassword(),
                                child: Text(
                                  "Mot de passe oublié?",
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: emailListner && passwdListner
                                    ? login
                                    : () {},
                                style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    splashFactory: emailListner && passwdListner
                                        ? InkRipple.splashFactory
                                        : NoSplash.splashFactory,
                                    enableFeedback: true,
                                    primary: emailListner && passwdListner
                                        ? Colors.indigo
                                        : Color.fromARGB(255, 109, 111, 122),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15)),
                                child: const Text(
                                  "Connexion",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.04),
                        Center(
                          child: TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                splashFactory: NoSplash.splashFactory,
                              ),
                              onPressed: () {
                                //TODO:
                                Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            CreateUserScreen()));
                              },
                              child: Text(
                                "Vous débutez chez Lablib ? Créér un compte",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.indigo, fontSize: 16),
                              )),
                        ),
                        SizedBox(height: size.height * 0.09),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
