import 'package:flutter/material.dart';

import 'components/care_view.dart';
import 'components/center_next_button.dart';
import 'components/mood_diary_vew.dart';
import 'components/relax_view.dart';
import 'components/top_back_skip_view.dart';

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
        AnimationController(vsync: this, duration: Duration(seconds: 4));

    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Widget listOfMesurs() {
    return Center(
      child: Container(
        child: Text("List Of Mesurs"),
      ),
    );
  }

  Widget AddNewMesure() {
    return ClipRect(
      child: Stack(
        children: [
          RelaxView(
            animationController: _animationController!,
          ),
          CareView(
            animationController: _animationController!,
          ),
          MoodDiaryVew(
            animationController: _animationController!,
          ),
          TopBackSkipView(
            onBackClick: _onBackClick,
            onSkipClick: _onSkipClick,
            animationController: _animationController!,
          ),
          CenterNextButton(
            animationController: _animationController!,
            onNextClick: _onNextClick,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController?.value);
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: _animationController!.value == 0.2
                ? 0
                : AppBar().preferredSize.height,
            title: Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: BorderRadius.circular(90),
                  onTap: (() {
                    //TODO:
                  }),
                  splashColor: Colors.white24,
                  child: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 38, 58, 167),
                    child: Text('HE'),
                  )),
            ),
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
                  onPressed: () {
                    setState(() {
                      _animationController?.animateTo(0.2);
                      _animationController?.value = 0.2;
                    });
                  },
                  child: Icon(IconData(0xe047, fontFamily: 'MaterialIcons')))
            ]),
        backgroundColor: Color(0xffF7EBE1),
        body:
            _animationController?.value == 0 ? listOfMesurs() : AddNewMesure());
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      setState(() {
        _animationController?.value = 0;
      });

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
    _animationController?.value = 0;
    setState(() {});
  }
}
