import 'package:flutter/material.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/add_dozes.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/doze_view.dart';
import 'package:medisafe/models/Rappel.dart';
import 'package:provider/provider.dart';

class NameMedi extends StatefulWidget {
  final AnimationController animationController;

  const NameMedi({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<NameMedi> createState() => _NameMediState();
}

class _NameMediState extends State<NameMedi> {
  @override
  Widget build(BuildContext context) {
    var changes = Provider.of<HomeProvider>(context, listen: true);
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );


    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: name(),
      ),
    );
  }
}

class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => contenu();
}

class contenu extends State<name> with TickerProviderStateMixin  {
  String? selectedValue1 = 'gouttes';
  String? selectedValue = 'everyday';


  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.2);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var row = Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 25, top: 30, bottom: 2),
          alignment: Alignment.topLeft,
          child: CustomText(
            text: 'nombre de jour:',
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 20),
        Container(
          margin: EdgeInsets.only(left: 25, top: 30, bottom: 2),
          width: 130,
          height: 30,
          child: TextField(
            keyboardType: TextInputType.number,
            // set the keyboard type to numeric
            onChanged: (text) {
              Rappel rap = Rappel();
              rap.setNbr(int.parse(text));
            },
            decoration: const InputDecoration(
              labelText: 'Enter a number', // set a label for the input box
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
          ),
        ),
      ],
    );
    var row2 = Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 25, top: 40, bottom: 2),
          alignment: Alignment.topLeft,
          child: CustomText(
            text: 'category:',
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 65),
        Container(
          margin: EdgeInsets.only(left: 25, top: 40, bottom: 2),
          width: 130,
          height: 30,
          child: TextField(
            keyboardType: TextInputType.text,
            // set the keyboard type to numeric
            onChanged: (text) {
              Rappel rap = Rappel();
              rap.setCategory(text);
            },
            decoration: const InputDecoration(
              labelText: 'Enter category', // set a label for the input box
              border: OutlineInputBorder(),
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
          ),
        ),
      ],
    );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return  SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: constraints.maxHeight * 0.12,
                  left: 8,
                  right: 8),
              height: MediaQuery.of(context).size.height * 0.58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // ignore: prefer_const_constructors
                    child: Padding(
                      padding: EdgeInsets.only(top: 36.0, left: 30, right: 30),
                      child: Center(
                        child: TextField(
                          onChanged: (text) {
                            Rappel rap = Rappel();
                            rap.setNom(text);

                          },
                          decoration: const InputDecoration(
                            labelText: 'Enter medicament\'s name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  row2,
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 30, bottom: 2),
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          text: 'Forme:',
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 84),
                      Container(
                        width: 120,
                        margin: EdgeInsets.only(left: 25, top: 30, bottom: 2),
                        child: DropdownButton<String>(
                          value: selectedValue1, // set the initial value
                          items: const [
                            DropdownMenuItem(
                              value: 'Sirops',
                              child: Text('Sirops'),
                            ),
                            DropdownMenuItem(
                              value: 'Pommade',
                              child: Text('Pommade'),
                            ),
                            DropdownMenuItem(
                              value: 'Comprimés',
                              child: Text('Comprimés'),
                            ),
                            DropdownMenuItem(
                              value: 'gouttes',
                              child: Text('Gouttes'),
                            ),
                            DropdownMenuItem(
                              value: 'Capsule',
                              child: Text('Capsule'),
                            ),
                          ],
                          onChanged: (value) {

                            Rappel rap = Rappel();
                            setState(() {
                              selectedValue1 = value;
                              rap.setForme(value!);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  row,
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 30, bottom: 2),
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          text: 'type de rappel:',
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 30, bottom: 2),
                        child: DropdownButton<String>(
                          value: selectedValue, // set the initial value
                          items: const [
                            DropdownMenuItem(
                              value: 'everyday',
                              child: Text('everyday'),
                            ),
                            DropdownMenuItem(
                              value: 'hebdomadaire',
                              child: Text('hebdomadaire'),
                            ),
                            DropdownMenuItem(
                              value: 'once a week',
                              child: Text('once a week'),
                            ),
                          ],
                          onChanged: (value) {

                            Rappel rap = Rappel();
                            setState(() {
                              selectedValue = value;
                              rap.setType(value!);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ), // your child widget here
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, top:MediaQuery.of(context).size.height * 0.1 ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < 2; i++)
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 480),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: 0 == i ? Color(0xff132137) : Color(0xffE3E4E4),
                        ),
                        width: 10,
                        height: 10,
                      ),
                    ),
                ],
              ),
            ),
            FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => CareView(),
                  ),
                );
              },
              child: const Icon(
                Icons.navigate_next,
                color: Colors.white,
              ),
            )
          ],),
        );
      },
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  CustomText({required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
