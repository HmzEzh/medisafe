import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/medicamentScreen/MedicamentScreen.dart';

import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/add_medi.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/top_back_skip_view.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/save_medi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import 'components/add_name.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  const IntroductionAnimationScreen({Key? key}) : super(key: key);

  @override
  _IntroductionAnimationScreenState createState() =>
      _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState
    extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {
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
    var changes = Provider.of<HomeProvider>(context, listen: true);
    print(_animationController?.value);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: ClipRect(
        child: Stack(
          children: [
           
            NameMedicament(
              animationController: _animationController!,
            ),

            // WelcomeView(
            //   animationController: _animationController!,
            // ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            /*CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),*/
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => MyApp()),
          // );
      Navigator.pop(context);
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.pop(context);
  }
}
