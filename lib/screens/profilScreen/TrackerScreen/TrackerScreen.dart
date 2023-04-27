import 'package:flutter/material.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/DesignScreen.dart';
import 'package:provider/provider.dart';

import '../../medicamentScreen/home_design.dart';


class TrackerScreen extends StatefulWidget {
  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  Widget build(BuildContext context) {
    var selectedDay = Provider.of<HomeProvider>(context, listen: true);

    return  DesignScreen();
  }
}
