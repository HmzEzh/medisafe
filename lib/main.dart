import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/homeScreen/HomeScreen.dart';
import 'package:medisafe/screens/medicamentScreen/MedicamentScreen.dart';
import 'package:medisafe/screens/profilScreen/ProfilScreen.dart';
import 'package:medisafe/screens/recomScreen/RecomScreen.dart';
import 'package:medisafe/service/notification_service.dart';
import 'package:provider/provider.dart';
import 'helpers/DatabaseHelper.dart';


final dbHelper = DatabaseHelper.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();
  await Noti.initialize(flutterLocalNotificationsPlugin);
  runApp(
     MultiProvider(
      providers: [
       ChangeNotifierProvider(
          create: (_) => HomeProvider()
        ),],
    child: const MyApp()));
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
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [const HomeScreen(),RecomScreen(),MedicamentScreen(),ProfilScreen()];

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
