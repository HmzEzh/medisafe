import 'package:medisafe/screens/medicamentScreen/rv_list_view.dart';
import 'package:medisafe/screens/medicamentScreen/medicament_list_view.dart';
import 'package:medisafe/main.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/screens/profilScreen/rendezVousScreen/AddRendezVous.dart';
import 'app_theme.dart';
import 'introduction_animation/introduction_add_medi.dart';

class DesignHomeScreen extends StatefulWidget {
  @override
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}

class _DesignCourseHomeScreenState extends State<DesignHomeScreen> {
  CategoryType categoryType = CategoryType.ui;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          children: <Widget>[
                            getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
                            const SizedBox(
                              width: 16,
                            ),
                            getButtonUI(
                                CategoryType.coding, categoryType == CategoryType.coding),
                            const SizedBox(
                              width: 16,
                            ),
                            getButtonUI(
                                CategoryType.basic, categoryType == CategoryType.basic),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                        child: getCategoryUI()),
                      Flexible(
                        child: getPopularCourseUI(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: Text(
                        'Rendez-vous',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          letterSpacing: 0.27,
                          color: DesignCourseAppTheme.darkerText,
                        ),
                      ),
                ),
                Container(
                 child:GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => AddRendezVous(),
                          ),
                        );
                      },
                      child: const Text(
                        'new \u2192',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.27,
                          color: DesignCourseAppTheme.nearlyBlue,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                ),
              ],
            )

        ),
        
        
        /*const SizedBox(
          height: 16,
        ),*/
        RendezVousListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return Container(
      
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 18, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Expanded(
                    child: Text(
                          'Medicament',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: DesignCourseAppTheme.darkerText,
                          ),
                        ),
                  ),
                  Container(
                   child:GestureDetector(
                     onTap: () {
                       Navigator.push<dynamic>(
                         context,
                         MaterialPageRoute<dynamic>(
                           builder: (BuildContext context) => IntroductionAnimationScreen(),
                         ),
                       );
                     },
                        child: const Text(
                          'new \u2192',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.27,
                            color: DesignCourseAppTheme.nearlyBlue,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            Container(
              
              child: Flexible(
                child: PopularCourseListView(
                  callBack: () {
                    moveTo();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void moveTo() {
    // Navigator.push<dynamic>(
    //   context,
    //   MaterialPageRoute<dynamic>(
    //     builder: (BuildContext context) => IntroductionAnimationScreen(),
    //   ),
    // );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'All';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Active';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Désactive';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? DesignCourseAppTheme.nearlyBlue
                : DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: DesignCourseAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for course',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*
                Text(
                  'Choose your',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  'Design Course',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),*/
                 getSearchBarUI(),
              ],
            ),
          ),
         /* Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/design_course/userImage.png'),
          )*/
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}