import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:medisafe/models/RendezVous.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/homeScreen/HomeScreen.dart';
import 'package:medisafe/screens/medicamentScreen/MedicamentScreen.dart';
import 'package:medisafe/models/medicament.dart';
import 'package:medisafe/screens/profilScreen/ProfilScreen.dart';
import 'package:medisafe/screens/recomScreen/RecomScreen.dart';
import 'package:medisafe/service/notification_service.dart';
import 'package:medisafe/service/rendezVousNotifService.dart';
import 'package:provider/provider.dart';
import 'helpers/DatabaseHelper.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

final dbHelper = DatabaseHelper.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

RendezVousNotifService rdvSrv = new RendezVousNotifService();

@pragma('vm:entry-point')
void rendezVousTask() async {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  try {
    RendezVous? rv = await rdvSrv.sendNotif();
    if (rv != null) {
      print(rv.nom);
      Noti.showBigTextNotification(
          id: rv.nom,
          title: "Rendez-vous",
          body: rv.nom,
          fln: flutterLocalNotificationsPlugin);
    }
  } catch (e) {
    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $e');
  }
  print(
      "[$now] Hello, world! isolate=${isolateId} function='$rendezVousTask' ##################################################################");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeProvider()),
  ], child: const MyApp()));

  Medicament.addCat();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    const HomeScreen(),
    RecomScreen(),
    MedicamentScreen(),
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
              icon: Icon(Icons.school),
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
