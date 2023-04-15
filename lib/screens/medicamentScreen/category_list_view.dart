import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/screens/medicamentScreen/design_course_app_theme.dart';
import 'package:medisafe/screens/medicamentScreen/models/category.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/main.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 134,
        width: double.infinity,
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: Category.categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = Category.categoryList.length > 10
                      ? 10
                      : Category.categoryList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return CategoryView(
                    category: Category.categoryList[index],
                    animation: animation,
                    animationController: animationController,
                    callback: widget.callBack,
                  );
                },
              );
            }
          },
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
  final Category? category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  DatabaseHelper medicamentService = DatabaseHelper.instance;

  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;

  void _refreshJournals() async{
    final data = await medicamentService.getMedicaments();
    final dozes = await medicamentService.getDozes();
    for(int i=0;i<data.length;i++){
      print("nombre dsata = ${data[i]}");
    }
    for(int i=0;i<dozes!.length;i++){
      print("dozes = ${dozes![i]}");
    }

    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.category!.addCat();
    _refreshJournals();

  }


  @override
  Widget build(BuildContext context) {


    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - widget.animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: widget.callback,
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Text(
                                              widget.category!.title,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16, bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                  Text(
                                                    '${widget.category!.date} ',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w200,
                                                      fontSize: 13,
                                                      letterSpacing: 0.27,
                                                      color: DesignCourseAppTheme
                                                          .grey,

                                                    ),
                                                  ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${widget.category!.heure}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 14,
                                                          letterSpacing: 0.27,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .grey,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.alarm,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .nearlyBlue,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16, right: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                widget.category!.etat ?Container(
                                                  margin: EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    '${widget.category!.etat ? "Active" : "Disabled"}',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15,
                                                      letterSpacing: 0.27,
                                                     color:  Color.fromARGB(255, 0, 255, 0) ,
                                                    ),
                                                  ),
                                                ):Container(
                                                  margin: EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    '${widget.category!.etat ? "Active" : "Disabled"}',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15,
                                                      letterSpacing: 0.27,
                                                     color:  Color.fromARGB(255, 255, 0, 0),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  decoration: const BoxDecoration(
                                                    color: DesignCourseAppTheme
                                                        .nearlyBlue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.0)),
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(
                                                            4.0),
                                                    child: Icon(
                                                      Icons.mode,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .nearlyWhite,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 24, left: 16),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Image.asset(widget.category!.imagePath)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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