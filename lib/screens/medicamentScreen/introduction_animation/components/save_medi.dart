import 'package:flutter/material.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/main.dart';
import 'package:medisafe/screens/medicamentScreen/MedicamentScreen.dart';
import 'package:medisafe/screens/medicamentScreen/models/Rappel.dart';

class WelcomeView extends StatefulWidget {
  
  @override
  _MyWidgetState createState() => _MyWidgetState();
}
class _MyWidgetState extends State<WelcomeView> {
  Rappel rap = Rappel();
  DatabaseHelper medicamentService = DatabaseHelper.instance;
  Future<void> _addMedi() async{
    int id = await medicamentService.insertMedicament(
        rap.nom.toString(),rap.type,"vitamins",rap.nombre
    );
    for(int i=0;i<rap.horaires.length;i++){
      await medicamentService.insertDoze(rap.horaires[i], id);
    }

    rap.horaires.clear();
  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {

    Rappel rap = Rappel();
    List<Widget> textWidgets = [];

    for (int i = 0; i < rap.horaires.length; i++) {
      textWidgets.add(Text(rap.horaires[i]!));
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: ClipRect(
          child: Stack(
            children: [
              Container(
  margin: EdgeInsets.only(left: 0,bottom:MediaQuery.of(context).size.height * 0.10, top:MediaQuery.of(context).size.height * 0.1),
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
  child: Padding(
    padding:EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.1,right:MediaQuery.of(context).size.width * 0.1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: Center(
                child: Text(
                  "Rappel's data",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
        ),
        SizedBox(height: 50),
        Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text("medicament  :",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(width: 20),
                Text(rap.getNom()),
              ],
        ),
        Divider(color: Colors.black),
        SizedBox(height: 8),
        Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text("type de rappel  :",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(width: 20),
                Text(rap.type),
              ],
        ),
        Divider(color: Colors.black),
        SizedBox(height: 8),
        Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text("nombre de jour   :",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(width: 20),
                Text(rap.nombre.toString()),
              ],
        ),
        Divider(color: Colors.black),
        SizedBox(height: 8),
        Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text("Horaire  :",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),

                ),
                SizedBox(width: 20),
                Column(
                  children: textWidgets,
                ),
              ],
        ),
        Divider(color: Colors.black),
        SizedBox(height: 8),


      ],
    ),
  ),),
              Positioned(
                bottom: 50,
                right: MediaQuery.of(context).size.width*0.3,
                child:SizedBox(
                    height: 50.0,
                    width: 150.0,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _addMedi();
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => MyApp(),
                      ),
                    );
                  },
                  icon: Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('INSERT'),
                      ],
                    ),
                  ),
                  label: Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.verified_user),

                      ],
                    ),
                  ),
                )
              ),),
            ],
          ))
  
);


  }
}

