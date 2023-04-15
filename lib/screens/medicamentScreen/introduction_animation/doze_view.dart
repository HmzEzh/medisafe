import 'package:flutter/material.dart';
import 'package:medisafe/main.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/user_model.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/save_medi.dart';
import 'package:medisafe/screens/medicamentScreen/models/Rappel.dart';

// ignore: camel_case_types
class Horaire extends StatefulWidget {
  const Horaire({super.key});

  @override
  State<Horaire> createState() => _HoraireState();
}

class _HoraireState extends State<Horaire> {
  UserModel userModel = UserModel();

  @override
  void initState() {
    super.initState();
    userModel.emails = List<String>.empty(growable: true);
    userModel.emails!.add("");
    userModel.emails!.add("");
    userModel.emails!.add("");
  }

  TimeOfDay _time = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    Rappel rap = Rappel();
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        rap.horaires.add(newTime.toString().substring(10, 15));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
      children: [
        Container(

            child: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, left: MediaQuery.of(context).size.width * 0.001),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Container(

                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0), // add some padding
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 191, 202, 211), // set background color
                        borderRadius: BorderRadius.circular(8.0), // round the corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // add some drop shadow
                          ),
                        ],
                      ),
                      child: Text(
                        'reminders per day',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  _emailsContainer(),
                ],
              ),
            ),
          ),
        )),
        Padding(
          padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
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
                      color: 1 == i ? Color(0xff132137) : Color(0xffE3E4E4),
                    ),
                    width: 10,
                    height: 10,
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => WelcomeView(),
                ),
              );
            },
            child: const Icon(
              Icons.navigate_next,
              color: Colors.white,
            ),
          ),
        )
      ],
    ));
  }

  Widget _emailsContainer() {
    return Container(
      padding: EdgeInsets.only(left: 18,top: 5,bottom: 5),
      margin:EdgeInsets.all(16.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         
          ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [emailUI(index)],
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: userModel.emails!.length,
          ),
        ],
      ),
    );
  }

  Widget emailUI(index) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'reminder: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 35.0),
          ElevatedButton(
            onPressed: () => _selectTime(context),
            child: Text('Select Time'),
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addEmailControl();
                },
              ),
            ),
            visible: index == userModel.emails!.length - 1,
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  removeEmailControl(index);
                },
              ),
            ),
            visible: index > 0,
          )
        ],
      ),
    );
  }

  void addEmailControl() {
    setState(() {
      userModel.emails!.add("");
    });
  }

  void removeEmailControl(index) {
    setState(() {
      if (userModel.emails!.length > 1) {
        userModel.emails!.removeAt(index);
      }
    });
  }
}
