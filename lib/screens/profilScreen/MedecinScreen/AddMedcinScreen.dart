import 'package:flutter/material.dart';

class AddMedcinScreen extends StatefulWidget {
  const AddMedcinScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<AddMedcinScreen> createState() => _AddMedcinScreenState();
}

class _AddMedcinScreenState extends State<AddMedcinScreen> {
  Widget section1(BuildContext context) {
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
      margin: EdgeInsets.only(top: 16,bottom: 0,left: 8,right: 8),
      //color: Colors.red,
      child: Column(children: [
        Container(
          child: TextFormField(
            decoration: InputDecoration(
               
              hintText: "Nom du médcin",
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
        Divider(
          color: Colors.grey,
          height: 2,
          indent: 24,
          endIndent: 24,
        ),
        Container(
          //color: Color.fromARGB(255, 246, 246, 246),
          child: TextFormField(
            decoration: InputDecoration(
               
              hintText: "Spécialité",
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
      margin: EdgeInsets.only(top: 16,bottom: 0,left: 8,right: 8),
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
      margin: EdgeInsets.only(top: 16,bottom: 0,left: 8,right: 8),
      //color: Colors.red,
      child: Column(children: [
        Row(children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16,right: 16),
            width: 10,
            child: Icon(Icons.location_on_outlined,color: Colors.blue,),
          ),
          Container(
            width: size.width - 60,
          child: TextFormField(
           
            decoration: InputDecoration(
               
              hintText: "Adresse",
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
        
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  IconData(0xe16a, fontFamily: 'MaterialIcons'),
                  color: Color.fromARGB(255, 38, 58, 167),
                )),
            Spacer(),
            Text("Ajouter un médcin",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 38, 58, 167))),
            Spacer(),
          ]),
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Color.fromARGB(255, 246, 246, 246),
          automaticallyImplyLeading: false,
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
                child: Text("sauver",style: TextStyle(
                  color: Color.fromARGB(255, 38, 58, 167)
                ),))
          ]),
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              section1(context),
              section2(context),
              section3(context),]
          ),
        ),
      
    );
  }
}
