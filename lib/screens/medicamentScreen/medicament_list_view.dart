import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/screens/medicamentScreen/app_theme.dart';
import 'package:medisafe/models/medicament.dart';
import 'package:medisafe/main.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/screens/medicamentScreen/profile_settings.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _PopularCourseListViewState createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }



  @override
  Widget build(BuildContext context) {
    DatabaseHelper medicamentService = DatabaseHelper.instance;;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: FutureBuilder<List<Medicament>>(
            future: medicamentService.getAllMedicaments(),
            builder: (context,  snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("wait"),
                );
              } else if (snapshot.hasError) {
                final error = snapshot.error;
                return Center(
                  child: Text(error.toString()),
                );
              } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
              return Center(
              child: Text("Try to add new one"),
              );
              }else{
                return GridView(
                  padding: const EdgeInsets.all(8),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 32.0,
                    childAspectRatio: 0.8,
                  ),
                  children: List<Widget>.generate(
                    Medicament.popularCourseList.length,
                    (int index) {
                      final int count = Medicament.popularCourseList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController?.forward();
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  //_showForm(widget.category!.id);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: HexColor('#F8FAFB'),

                                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                                    // border: new Border.all(
                                    //     color: DesignCourseAppTheme.notWhite),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16, left: 16, right: 16),
                                                child: Text(
                                                  snapshot.data![index].title,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme.darkerText,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, left: 16, right: 16, bottom: 8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    const Text(
                                                      'End :',
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w200,
                                                        fontSize: 12,
                                                        letterSpacing: 0.27,
                                                        color: DesignCourseAppTheme.grey,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            '${snapshot.data![index].dateFin}',
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w200,
                                                              fontSize: 18,
                                                              letterSpacing: 0.27,
                                                              color: DesignCourseAppTheme.grey,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.calendar_month,
                                                            color: DesignCourseAppTheme.nearlyBlue,
                                                            size: 18,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: SizedBox(
                                                    height: 75,
                                                    width: 128,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          top: 0, right: 16, left: 16),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(
                                                              Radius.circular(16.0)),
                                                          boxShadow: <BoxShadow>[
                                                            BoxShadow(
                                                                color: DesignCourseAppTheme.grey
                                                                    .withOpacity(0.2),
                                                                offset: const Offset(0.0, 0.0),
                                                                blurRadius: 6.0),
                                                          ],
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: const BorderRadius.all(
                                                              Radius.circular(16.0)),
                                                          child: AspectRatio(
                                                              aspectRatio: 1.28,
                                                              child:
                                                              Image.asset(snapshot.data![index].imagePath)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );}
              }
              return Container();
            }
          ),
        ),
      ),
    );
  }
}

class CategoryView extends StatefulWidget {
  const CategoryView(
      {Key? key,
      this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Medicament? category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {


  @override
  Widget build(BuildContext context) {
    DatabaseHelper medicamentService = DatabaseHelper.instance;;

    // void _delete(int id) async {
    //   await medicamentService.deleteMedicament(id);
    //
    //   setState(() {
    //     widget.category?.dod(Category(
    //       id: id,
    //       imagePath: 'assets/images/medicine.png',
    //       title: widget.category!.title,
    //       date: widget.category!.date,
    //       etat: false,
    //       heure: widget.category!.heure,
    //     ));
    //   });
    // }

    void _delete(int id) async {
      await medicamentService.deleteMedicament(id);

      setState(() {
        Medicament.popularCourseList.removeWhere((category) => category.id == id);
        print(Medicament.categoryList.toString());
      });
    }




    void _showForm(int? id) async{


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
                  controller: TextEditingController(text: medi[0]['nom']),
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
                          Navigator.push<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => ProfileSettingScreen(),
                            ),
                          );

                          // Perform action when 'Yes' button is pressed
                          Navigator.pop(context);
                          // ... do something else ...
                        },
                        child: Text('Update'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _delete(id);

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
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                _showForm(widget.category!.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),

                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  // border: new Border.all(
                  //     color: DesignCourseAppTheme.notWhite),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              child: Text(
                                widget.category!.title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: 0.27,
                                  color: DesignCourseAppTheme.darkerText,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 16, right: 16, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'end :',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.grey,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '${widget.category!.dateDebut}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 18,
                                            letterSpacing: 0.27,
                                            color: DesignCourseAppTheme.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_month,
                                          color: DesignCourseAppTheme.nearlyBlue,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: SizedBox(
                                  height: 75,
                                  width: 128,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, right: 16, left: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: DesignCourseAppTheme.grey
                                                  .withOpacity(0.2),
                                              offset: const Offset(0.0, 0.0),
                                              blurRadius: 6.0),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        child: AspectRatio(
                                            aspectRatio: 1.28,
                                            child:
                                                Image.asset(widget.category!.imagePath)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
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
