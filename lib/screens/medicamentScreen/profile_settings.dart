import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/main.dart';
import 'package:medisafe/models/Doze.dart';
import 'package:medisafe/models/Rappel.dart';
import 'package:medisafe/models/medicament.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key,required this.medicament,
  }) : super(key: key);
  final Medicament medicament;

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController finController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();



  @override
  void initState() {
    nameController.text = widget.medicament.title;
    categoryController.text = widget.medicament.category;
    typeController.text = widget.medicament.type;
    finController.text = widget.medicament.dateFin;
  }


  File? selectedImage;

  void _showForm(int? id) async{

DatabaseHelper medicamentService = DatabaseHelper.instance;
    final medi = await medicamentService.getMedicamentById(id!);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: TextEditingController(text: id.toString()),
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width * 0.05 ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push<dynamic>(
                        //   context,
                        //   MaterialPageRoute<dynamic>(
                        //     builder: (BuildContext context) => ProfileSettingScreen(
                        //       medicament: snapshot.data![index],
                        //     ),
                        //   ),
                        // );

                        // Perform action when 'Yes' button is pressed
                        Navigator.pop(context);
                        // ... do something else ...
                      },
                      child: Text('Update'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // _delete(id);

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

  }
  bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    DatabaseHelper dozeservice = DatabaseHelper.instance;
    var changes = Provider.of<HomeProvider>(context, listen: true);
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

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {

                        },
                        child:Padding(
                          padding:  EdgeInsets.only(left:80.0),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.04,bottom: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/medicine.png'),
                                    fit: BoxFit.scaleDown,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Color(0xffD6D6D6),
                                ),
                              ),


                              Padding(
                                padding: EdgeInsets.only(left:10,top: 55.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "active",
                                      style: TextStyle(
                                        fontFamily: "Arial",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Switch(
                                        value: _switchValue,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _switchValue = value;
                                          });
                                          // Perform some action here based on the new value
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )

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
                height: 0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                          'Name', Icons.medication_liquid, nameController,(String? input){

                            if(input!.isEmpty){
                              return 'Name is required!';
                            }

                            if(input.length<5){
                              return 'Please enter a valid name!';
                            }

                            return null;

                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          'Category', Icons.category_outlined, categoryController,(String? input){

                            if(input!.isEmpty){
                              return 'Home Address is required!';
                            }

                            return null;

                      },onTap: ()async{

                      },
                        //  readOnly: true
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget('Type', Icons.calendar_month_rounded,
                          typeController,(String? input){
                            if(input!.isEmpty){
                              return 'Business Address is required!';
                            }

                            return null;
                          },onTap: ()async{

                          },readOnly: true),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget('date_Fin',
                          Icons.pause_circle_outline, finController,(String? input){
                            if(input!.isEmpty){
                              return 'Shopping Center is required!';
                            }

                            return null;
                          },onTap: ()async{

                },readOnly: false),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [

                            Text("Rappels"),
                          Padding(
                            padding: EdgeInsets.only(left: 268.0),
                            child: Container(
                                child: GestureDetector(
                                  onTap: () {
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

                                          dozeservice.insertDoze(_time.toString().substring(10, 15), widget.medicament.id);
                                          changes.setChanges();
                                        });
                                      }
                                    }
                                    _selectTime(context);
                                  },
                                  child: Icon(
                                    Icons.add_alarm_sharp,
                                    color: Colors.lightBlueAccent,
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                     Container(

                       width: MediaQuery.of(context).size.width ,
                      height: MediaQuery.of(context).size.height * 0.33,
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: const BorderRadius.only(
                           topLeft: Radius.circular(20),
                           topRight: Radius.circular(20),
                           bottomLeft: Radius.circular(10),
                           bottomRight: Radius.circular(10),
                         ),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.5),
                             spreadRadius: 1,
                             blurRadius: 1,
                             offset: Offset(0, 3),
                           ),
                         ],
                       ),
                      child: FutureBuilder<List<Doze>>(
                            future: dozeservice.getDozesByIdMed(widget.medicament.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: Center(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        height: MediaQuery.of(context).size.height * 0.7,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(90),
                                            color: Color.fromARGB(36, 81, 86, 90)),
                                        child: Center(
                                            child: CupertinoActivityIndicator(
                                              radius: 20,
                                            )),
                                      )),
                                );
                              } else if (snapshot.hasError) {
                                final error = snapshot.error;
                                return Center(
                                  child: Text(error.toString()),
                                );
                              } else if (snapshot.hasData) {
                                if (snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text("No reminder is set, Try to add one."),
                                  );
                                }

                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (ctx, index) {

                                      return Dismissible(
                                        key: UniqueKey(),
                                        onDismissed: (direction) {
                                          // Delete the item from the data source.
                                          setState(() {
                                            temp = snapshot.data![index].idMedicament;
                                            heure1 =snapshot.data![index].heure;

                                            dozeservice.deleteDoze( snapshot.data![index].id!);
                                            changes.notifyListeners();
                                            //snapshot.data!.removeAt(index);
                                          });
                                          // Show a snackbar to indicate item was deleted.
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("reminder deleted"),
                                              duration: Duration(seconds: 2),
                                              action: SnackBarAction(
                                                label: "UNDO",
                                                onPressed: () {
                                                  // Add the item back to the data source.
                                                  setState(() {
                                                    dozeservice.insertDoze(heure1, temp);


                                                    changes.notifyListeners();
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: InkWell(
                                          onTap: () {
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
                                                  final row = {'idMedicament':snapshot.data![index].idMedicament!, 'heure':_time.toString().substring(10, 15),'suspend':snapshot.data![index].suspend!?1:0};
                                                  dozeservice.updateDoze(row, snapshot.data![index].id!);
                                                  changes.notifyListeners();
                                                });
                                              }
                                            }
                                            _selectTime(context);
                                            //_showForm(snapshot.data![index].id);
                                            // print(snapshot.data![index].id);
                                            // Navigator.push<dynamic>(
                                            //   context,
                                            //   MaterialPageRoute<dynamic>(
                                            //       builder: (BuildContext context) =>
                                            //           MedcinsInfosScreen(
                                            //             doctor: snapshot.data![index],
                                            //           )),
                                            // );
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [

                                              Container(
                                                decoration: BoxDecoration(
                                                  //color: Color.fromARGB(255, 246, 246, 246),
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(4)),
                                                  // border: Border.all(
                                                  //     color: DesignCourseAppTheme.nearlyBlue)
                                                ),

                                                width: MediaQuery.of(context).size.width,
                                                height: 50,
                                                //height: 200,
                                                margin: EdgeInsets.only(
                                                    top: 4, bottom: 0, left: 8, right: 8),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      Spacer(
                                                        flex: 1,
                                                      ),
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                        Color.fromRGBO( 183, 226, 240,
                                                            0.8),
                                                        child: snapshot
                                                            .data![index].heure.length >=
                                                            2
                                                            ? Text((index+1).toString(),style: TextStyle(color: Colors.white
                                                        ),)
                                                            : Text(snapshot.data![index].heure),
                                                      ),
                                                      Spacer(
                                                        flex: 2,
                                                      ),
                                                      Text(
                                                        snapshot.data![index].heure,
                                                        style: TextStyle(fontSize: 16),
                                                      ),
                                                      Spacer(
                                                        flex: 15,
                                                      ),
                                                      Icon(Icons.edit,
                                                        color: Color.fromRGBO(0, 0, 1, 0.4),),
                                                      Padding(
                                                        padding:  EdgeInsets.only(right: 8.0),
                                                        child: Icon(Icons.delete_sweep,
                                                          color: Colors.redAccent,),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 2,
                                                indent: 80,
                                                endIndent: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Container();
                            }),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 6,),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        insetPadding: EdgeInsets.symmetric(horizontal: 60),
                                        buttonPadding: EdgeInsets.zero,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10.0))),
                                        contentPadding:
                                        const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
                                        title: const Text(
                                          'update',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.w600),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 200,
                                              margin: const EdgeInsets.only(
                                                  left: 8, right: 8, bottom: 24),
                                              child: const Text(
                                                "Do you want to save changes ?",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: InkWell(
                                                      borderRadius: const BorderRadius.only(
                                                        bottomLeft: Radius.circular(10),
                                                      ),
                                                      onTap: () => Navigator.pop(context),
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            border: Border(
                                                                top: BorderSide(
                                                                    color: Colors.grey),
                                                                right: BorderSide(
                                                                    color: Colors.grey))),
                                                        height: 50,
                                                        child: const Center(
                                                          child: Text("Cancel",
                                                              style: TextStyle(
                                                                  color: Colors.blue,
                                                                  fontWeight: FontWeight.w600)),
                                                        ),
                                                      ),
                                                    )),
                                                Expanded(
                                                    child: InkWell(
                                                      borderRadius: const BorderRadius.only(
                                                        bottomRight: Radius.circular(10),
                                                      ),
                                                      //TODO:
                                                      onTap: () async {
                                                        try {
                                                          Navigator.pop(context);

                                                          final data = {'nom':nameController.text, 'type':typeController.text, 'category':categoryController.text,'dateFin':finController.text};
                                                          await dozeservice
                                                              .updateMedicament(data, widget.medicament.id);

                                                          changes.setChanges();
                                                           Navigator.pop(context);
                                                          // Navigator.push<dynamic>(
                                                          //   context,
                                                          //   MaterialPageRoute<dynamic>(
                                                          //     builder: (BuildContext context) => MyApp( nbr: 2,),
                                                          //   ),
                                                          // );
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(SnackBar(
                                                            content: Container(
                                                                padding: EdgeInsets.only(
                                                                    top: 0, bottom: 2),
                                                                child: Text(
                                                                  "the medication reminder is updated",
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
                                                        } catch (e) {}
                                                      },
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            border: Border(
                                                              top: BorderSide(color: Colors.grey),
                                                            )),
                                                        height: 50,
                                                        child: const Center(
                                                          child: Text(
                                                            "Update",
                                                            style: TextStyle(color: Colors.blue),
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
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
                                      'Update',
                                      style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        insetPadding: EdgeInsets.symmetric(horizontal: 60),
                                        buttonPadding: EdgeInsets.zero,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10.0))),
                                        contentPadding:
                                        const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
                                        title: const Text(
                                          'Delete',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.w600),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 200,
                                              margin: const EdgeInsets.only(
                                                  left: 8, right: 8, bottom: 24),
                                              child: const Text(
                                                "Are you sure ?",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: InkWell(
                                                      borderRadius: const BorderRadius.only(
                                                        bottomLeft: Radius.circular(10),
                                                      ),
                                                      onTap: () => Navigator.pop(context),
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            border: Border(
                                                                top: BorderSide(
                                                                    color: Colors.grey),
                                                                right: BorderSide(
                                                                    color: Colors.grey))),
                                                        height: 50,
                                                        child: const Center(
                                                          child: Text("Cancel",
                                                              style: TextStyle(
                                                                  color: Colors.blue,
                                                                  fontWeight: FontWeight.w600)),
                                                        ),
                                                      ),
                                                    )),
                                                Expanded(
                                                    child: InkWell(
                                                      borderRadius: const BorderRadius.only(
                                                        bottomRight: Radius.circular(10),
                                                      ),
                                                      //TODO:
                                                      onTap: () async {
                                                        try {
                                                          Navigator.pop(context);
                                                          await dozeservice
                                                              .deleteMedicament(widget.medicament.id);
                                                          setState(() {
                                                            Medicament.popularCourseList.removeWhere((category) => category.id == widget.medicament.id);

                                                          });
                                                          changes.setChanges();
                                                          Navigator.pop(context);
                                                          // Navigator.push<dynamic>(
                                                          //   context,
                                                          //   MaterialPageRoute<dynamic>(
                                                          //     builder: (BuildContext context) => MyApp( nbr: 2,),
                                                          //   ),
                                                          // );
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(SnackBar(
                                                            content: Container(
                                                                padding: EdgeInsets.only(
                                                                    top: 0, bottom: 2),
                                                                child: Text(
                                                                  "the medication reminder is deleted",
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
                                                        } catch (e) {}
                                                      },
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            border: Border(
                                                              top: BorderSide(color: Colors.grey),
                                                            )),
                                                        height: 50,
                                                        child: const Center(
                                                          child: Text(
                                                            "Sure",
                                                            style: TextStyle(color: Colors.blue),
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 22, 67, 0.1),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.red,
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