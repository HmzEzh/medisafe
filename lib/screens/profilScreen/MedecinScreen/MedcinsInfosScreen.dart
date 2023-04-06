import 'package:flutter/material.dart';

class MedcinsInfosScreen extends StatefulWidget {
  const MedcinsInfosScreen({
    Key? key,
    required this.doctorId,
  }) : super(key: key);
  final int doctorId;
  @override
  State<MedcinsInfosScreen> createState() => _MedcinsInfosScreenState();
}

class _MedcinsInfosScreenState extends State<MedcinsInfosScreen> {
  Widget section1(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Color.fromARGB(255, 38, 58, 167),
                child: Text(list[widget.doctorId].substring(0, 2)),
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                width: size.width - 100,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nom du médcin",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 20,
              )
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 62,
          endIndent: 24,
        ),
        Container(
          //color: Color.fromARGB(255, 246, 246, 246),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Spécialité",
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget section2(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        InkWell(
          onTap: () {
            showModalBottomSheet<void>(
                constraints: BoxConstraints(
                    minWidth: size.width,
                    maxHeight: size.height-100,
                    minHeight: size.height - 100),
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0))),
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                     
                      //margin: EdgeInsets.only(top: 8),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                TextButton(
                style: ButtonStyle(
                  // minimumSize : MaterialStateProperty.all(Size(0,0)),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {},
                child: Text(
                  "Mettre à jour",
                  style: TextStyle(color: Color.fromARGB(255, 38, 58, 167)),
                ))
                              ],
                            ),
                            coor(context),
                            section3(context)
                          ],
                        ),
                      )
                    );
                  });
                });
          },
          child: Container(
             height: 40,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: 10,
                  child: Icon( Icons.contact_mail_outlined ,color:Colors.blue, )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  
                  child: Text("Coordonnées")
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Container(
           height: 40,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16),
                width: 10,
                child: Icon(
                  Icons.business_outlined,
                  color: Colors.blue,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("Rendez-vous")
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Container(
           height: 40,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16),
                width: 10,
                child: Icon(
                  Icons.phone_iphone_outlined,
                  color: Colors.blue,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("Médicaments")
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget section3(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
      //color: Colors.red,
      child: Column(children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 10,
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.blue,
              ),
            ),
            Container(
              width: size.width - 60,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Adresse",
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
   Widget coor(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
       decoration: BoxDecoration(
       color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        // border: Border.all(
        //     color: DesignCourseAppTheme.nearlyBlue)
      ),

      width: size.width,
      //height: 200,
      margin: EdgeInsets.only(top: 0,bottom: 0,left: 8,right: 8),
      //color: Colors.red,
      child: Column(children: [
        Row(children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16,right: 16),
            width: 10,
            child: Icon(IconData(0xf018, fontFamily: 'MaterialIcons'),color: Colors.blue,),
          ),
          Container(
            width: size.width - 60,
          child: TextFormField(
           
            decoration: InputDecoration(
               
              hintText: "doctor@mail.com",
              isDense: true,
              border:
                  OutlineInputBorder(
                borderSide:
                    BorderSide.none,
                borderRadius:
                    BorderRadius
                        .circular(5),
              ),
            ),
          ),
        ),
        ],),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
        Row(children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16,right: 16),
            width: 10,
            child: Icon(Icons.business_outlined,color: Colors.blue,),
          ),
          Container(
            width: size.width - 60,
          child: TextFormField(
           
            decoration: InputDecoration(
               
              hintText: "Numéro du bureau",
              isDense: true,
              border:
                  OutlineInputBorder(
                borderSide:
                    BorderSide.none,
                borderRadius:
                    BorderRadius
                        .circular(5),
              ),
            ),
          ),
        ),
        ],),
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 52,
          endIndent: 0,
        ),
       Row(children: [
           Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16,right: 16),
            width: 10,
            child: Icon( Icons.phone_iphone_outlined,color: Colors.blue,),
          ),
          Container(
            width: size.width - 60,
          child: TextFormField(
           
            decoration: InputDecoration(
               
              hintText: "Numéro de portable",
              isDense: true,
              border:
                  OutlineInputBorder(
                borderSide:
                    BorderSide.none,
                borderRadius:
                    BorderRadius
                        .circular(5),
              ),
            ),
          ),
        ),
        ],)
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                IconData(0xe16a, fontFamily: 'MaterialIcons'),
                color: Color.fromARGB(255, 38, 58, 167),
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
                onPressed: () {},
                child: Text(
                  "Mettre à jour",
                  style: TextStyle(color: Color.fromARGB(255, 38, 58, 167)),
                ))
          ]),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          section1(context),
          section2(context),
          
        ]),
      ),
    );
  }
}

var list = ["doctor1", "doctor2", "doctor3", "doctor4", "doctor5"];
