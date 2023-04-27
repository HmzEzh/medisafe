import 'package:flutter/material.dart';

class RecomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                backgroundColor: Colors.white,
                child: const Text('HE'),
              )),
            shadowColor: Colors.transparent,
            backgroundColor: Color.fromARGB(255, 27, 62, 92),
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
                  child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons'),color: Colors.white,))
            ]),
      body: const Center(
          child: Text("recomendation")),
    );
  }
}
