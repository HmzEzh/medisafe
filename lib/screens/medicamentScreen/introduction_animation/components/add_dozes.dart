import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:medisafe/screens/introduction_animation/components/care_view.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/top_back_skip_view.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/doze_view.dart';

class CareView extends StatefulWidget implements TickerProvider {
  final AnimationController animationController;

  const CareView({
    Key? key,
    required this.animationController,
  }) : super(key: key);
@override
_CareViewState createState() => _CareViewState();

@override
Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

class _CareViewState extends State<CareView>with TickerProviderStateMixin {
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
    void _onBackClick() {
      Navigator.pop(context);
      print("youssef");
    }

    void _onSkipClick() {
      Navigator.pop(context);
    }
    final _animation =
    Tween<Offset>(begin: Offset(0, -1), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _skipAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
        .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
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
                  SlideTransition(
                  position: _animation,
                  child: Padding(
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
                            SlideTransition(
                              position: _skipAnimation,
                              child: IconButton(
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                ]),
              ],
            ),
          ), Horaire()
        ],
      ),
    )));
  }
}


