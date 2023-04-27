import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/introduction_animation/components/care_view.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/save_medi.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/top_back_skip_view.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/doze_view.dart';
import 'package:provider/provider.dart';

class CareView extends StatefulWidget implements TickerProvider {


  const CareView({
    Key? key,

  }) : super(key: key);
@override
_CareViewState createState() => _CareViewState();

@override
Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

class _CareViewState extends State<CareView>with TickerProviderStateMixin {

     
  @override
  Widget build(BuildContext context) {
    var changes = Provider.of<HomeProvider>(context, listen: true);


    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
    body: ClipRect(child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.006),
            child: Row(
              children: [
                Stack(
                    children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Container(
                      height: 58,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SlideTransition(
                            //   position: _backAnimation,
                            //   child:
                             IconButton(
                                onPressed: () { Navigator.pop(context);},
                                icon: Icon(Icons.arrow_back_ios_new_rounded),
                              ),


                            SizedBox(width: 270),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                icon: Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ]),
              ],
            ),
          ), Horaire(),
          Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height *0.117,bottom: MediaQuery.of(context).size.height * 0.008),
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
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.08),
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
      ),
    )));
  }
}


