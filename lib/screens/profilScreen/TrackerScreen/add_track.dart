import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/main.dart';
import 'package:medisafe/models/Doze.dart';
import 'package:medisafe/models/Rappel.dart';
import 'package:medisafe/models/medicament.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/use/MyModel.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

import '../../../service/serviceLocator.dart';


class AddTrackerScreen extends StatefulWidget {


  @override
  State<AddTrackerScreen> createState() => _AddTrackerScreenState();
}

class _AddTrackerScreenState extends State<AddTrackerScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // nameController.text = widget.medicament.title;
    // categoryController.text = widget.medicament.category;
     typeController.text = "glycémie";
    // finController.text = widget.medicament.dateFin;
  }

  int _selectedContainerIndex = 0;
  File? selectedImage;

  double _currentSliderValue = 1;
  bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    DatabaseHelper dozeservice = DatabaseHelper.instance;
    var selectedDay = Provider.of<HomeProvider>(context, listen: true);
    var temp;
    var heure1;


    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                child: Stack(
                  children: [
                    SizedBox(height:MediaQuery.of(context).size.height*0.04),


                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {

                        },
                        child:Padding(
                          padding:  EdgeInsets.only(left:8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.08),
                                child: Container(child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () { Navigator.pop(context);},
                                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                                    ),
                                    Text("Hi youssef !", style: TextStyle(fontSize: 35, color:Color.fromARGB(255, 27, 62, 92)),),
                                  ],
                                )),
                              ),
                              Container(
                                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.04,bottom: 10),
                                child: Text("Create your Tracker", style: TextStyle(fontSize: 26, color:Color.fromRGBO(0, 0, 0, 0.3)
                                ,fontStyle: FontStyle.italic),),
                              ),


                            ],
                          ),
                        )
                        ,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                          'Name:', Icons.ssid_chart, nameController,(String? input){

                        if(input!.isEmpty){
                          return 'Name is required!';
                        }

                        if(input.length<5){
                          return 'Please enter a valid name!';
                        }

                        return null;

                      }),
                      const SizedBox(
                        height: 30,
                      ),


                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Number of weeks:',
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(

                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ],
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('1 week'),
                                    Text('12 weeks'),
                                  ],
                                ),
                                Slider(
                                  value: _currentSliderValue,
                                  min: 1,
                                  max: 12,
                                  activeColor: Color.fromARGB(255, 27, 62, 92),
                                  divisions: 11,
                                  label: _currentSliderValue.round().toString() + ' weeks',
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentSliderValue = value;
                                    });
                                  },
                                ),
                                Text(
                                  _currentSliderValue.round().toString() + ' weeks',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text("Type of Tracker:",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,),),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          children: [
                            SizedBox(width: 40),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedContainerIndex = 0;
                                  typeController.text = "glycémie";
                                });
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: _selectedContainerIndex == 0
                                      ? Color.fromARGB(255, 27, 62, 92)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5.0,),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: Image(
                                        image: AssetImage('assets/images/glycemie.png'),
                                      ),
                                    ),
                                    SizedBox(height: 7.0,),
                                    Container(child: Text("glycémie",style: TextStyle(
                                        color:_selectedContainerIndex == 0
                                            ? Colors.white : Colors.black,fontWeight: FontWeight.w500
                                    ),)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedContainerIndex = 1;
                                  typeController.text = "tension";
                                });
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: _selectedContainerIndex == 1
                                      ? Color.fromARGB(255, 27, 62, 92)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5.0,),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: Image(
                                        image: AssetImage('assets/images/blood-pressure.png'),
                                      ),
                                    ),
                                    SizedBox(height: 7.0,),
                                    Container(child: Text("tension",style: TextStyle(
                                        color:_selectedContainerIndex == 1
                                            ? Colors.white : Colors.black,fontWeight: FontWeight.w500
                                    ),)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 6,),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () async {

                                  dozeservice.insertTracker(nameController.text, typeController.text, _currentSliderValue.round() );

                                  Navigator.pop(context);
                                  selectedDay.setChanges();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Container(
                                        padding: EdgeInsets.only(
                                            top: 0, bottom: 2),
                                        child: Text(
                                          "Tracker created successfully",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor:
                                    Color.fromARGB(255, 75, 138, 220),
                                    margin: EdgeInsets.only(
                                        bottom: 20, left: 25, right: 25),
                                  ));
                                  Provider.of<MyModel>(context, listen: false).increment();
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(121, 119, 119, 0.1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Create',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 27, 62, 92),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      )



                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFieldWidget(
      String title, IconData iconData, TextEditingController controller,Function validator,{Function? onTap,bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,)
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          // height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            readOnly: readOnly,
            onTap: ()=> onTap!(),
            validator: (input)=> validator(input),
            controller: controller,

            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  iconData,

                ),
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget greenButton(String title, Function onPressed) {
    return MaterialButton(

      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

      onPressed: () => onPressed(),
      child: Text(
        title,

      ),
    );
  }
}