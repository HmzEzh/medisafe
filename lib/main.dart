import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:medisafe/models/RendezVous.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/flashscreen.dart';
import 'package:medisafe/screens/homeScreen/HomeScreen.dart';
import 'package:medisafe/screens/loginScreen.dart';
import 'package:medisafe/screens/medicamentScreen/MedicamentScreen.dart';
import 'package:medisafe/models/medicament.dart';
import 'package:medisafe/screens/profilScreen/ProfilScreen.dart';
import 'package:medisafe/screens/recomScreen/RecomScreen.dart';
import 'package:medisafe/service/notification_service.dart';
import 'package:medisafe/service/notifService.dart';
import 'package:medisafe/service/serviceLocator.dart';
import 'package:provider/provider.dart';
import 'helpers/DatabaseHelper.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

final dbHelper = DatabaseHelper.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

NotifService notifService = new NotifService();

@pragma('vm:entry-point')
void rendezVousTask() async {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  try {
    RendezVous? rv = await notifService.sendRendezVousNotif();
    if (rv != null) {
      print(rv.nom);
      Noti.showBigTextNotification(
          id: rv.nom,
          title: "Rendez-vous",
          body: rv.nom,
          fln: flutterLocalNotificationsPlugin);
    }
  } catch (e) {
    print(e);
  }
  try {
    String time = await notifService.sendmedicamentsNotif();
    if (time != "") {
      //print(time);
      Noti.showBigTextNotification(
          id: time,
          title: "Salut, c'est l'heure de prendre vos médicaments.",
          body: "Prenez le(s) médicament(s) que vous devez prendre à $time",
          fln: flutterLocalNotificationsPlugin);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  // Workmanager().initialize(callbackDispatcher);
  // initialize the database
  await AndroidAlarmManager.initialize();
  final int helloAlarmID = 3;
  await AndroidAlarmManager.periodic(
      const Duration(minutes: 1), helloAlarmID, rendezVousTask);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dbHelper.init();
  await Noti.initialize(flutterLocalNotificationsPlugin);
  // Define the task constraints
  setup();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeProvider()),
  ], child: const MyApp()));

  Medicament.addCat();
}

enum LogMode { loggedin, loggedOut, flashscreen }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final storage = const FlutterSecureStorage();
  LogMode logmode = LogMode.flashscreen;
  void getToken() async {
    String? token = await storage.read(key: 'token');
    if (token == null) {
      setState(() {
        logmode = LogMode.loggedOut;
      });
    } else {
      setState(() {
        logmode = LogMode.loggedin;
      });
    }
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => logmode == LogMode.flashscreen
            ? FlashScreen()
            : logmode == LogMode.loggedOut
                ? const LoginScreen()
                : MyHomePage()
        // {
        //   if (logmode == LogMode.loggedOut) {
        //     return const LoginScreen();
        //   } else {
        //     return const MyHomePage();
        //   }
        // }

        // When navigating to the "/second" route, build the SecondScreen widget.
        //'/second': (context) => const SecondScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int nbr = 0;
  _MyHomePageState();
  late int _selectedIndex = nbr;
  @override
  void initState() {
    // Workmanager().registerPeriodicTask(
    //   'mTask',
    //   'mTask',
    //   frequency: Duration(minutes: 1),
    // );
    // TODO: implement initState
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    const HomeScreen(userId: 1),
    RecomScreen(userId: 1),
    MedicamentScreen(userId: 1),
    ProfilScreen(userId: 1)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(appbar[_selectedIndex]),
        // ),
        body: SafeArea(
            child: IndexedStack(
          index: _selectedIndex,
          children: screens,
        )),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xf1c2, fontFamily: 'MaterialIcons')),
              label: 'Recomendation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medication),
              label: 'Medicament',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 35, 133, 172),
          onTap: _onItemTapped,
        ));
  }
}
