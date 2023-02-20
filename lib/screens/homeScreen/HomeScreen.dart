import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(  
          title: TextButton(
                  style: ButtonStyle(
                     minimumSize : MaterialStateProperty.all(Size(0,0)),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    print("test");
                  },
                  child:CircleAvatar(
                backgroundColor: Color.fromARGB(255, 38, 58, 167),
                child: const Text('HE'),
              )),
            shadowColor: Colors.transparent,
            backgroundColor: Color.fromARGB(255, 246, 246, 246),
            automaticallyImplyLeading: false,
            centerTitle: false,
            actions: [
              TextButton(
                  style: ButtonStyle(
                    // minimumSize : MaterialStateProperty.all(Size(0,0)),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    print("test");
                  },
                  child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons')))
            ]),
        backgroundColor: Colors.white,
        body: const Center(child: Text("Home")));
  }
}
