import 'package:flutter/material.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/doze_view.dart';

class CareView extends StatelessWidget {

     
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
    body: ClipRect(
    child: Horaire()));
  }
}


