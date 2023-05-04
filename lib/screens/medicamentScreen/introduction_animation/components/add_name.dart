import 'package:flutter/material.dart';
import 'package:medisafe/provider/HomeProvider.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/components/add_dozes.dart';
import 'package:medisafe/screens/medicamentScreen/introduction_animation/doze_view.dart';
import 'package:medisafe/models/Rappel.dart';
import 'package:provider/provider.dart';

import '../../../../app_skoleton/appSkoleton.dart';
import '../../../../controller/SearchController.dart';
import '../../../../service/serviceLocator.dart';
import 'add_medi.dart';

class NameMedicament extends StatefulWidget {
  final AnimationController animationController;

  const NameMedicament({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<NameMedicament> createState() => _NameMedicamentState();
}

class _NameMedicamentState extends State<NameMedicament> {
  final inputontroller = TextEditingController();
  final searchController = getIt<SearchController>();
  Future<List>? response;
  bool hasError = false;

  void search(String c) {
    setState(() {
      response = searchController.getMedsNames(c, 0);
    });
  }

  Widget searchResult() {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List>(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 12,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (ctx, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 15),
                            width: size.width / 1.5,
                            height: size.height / 9,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppSkoleton(
                                      width: size.width / 4,
                                      height: 13,
                                      margin: const EdgeInsets.only(bottom: 10),
                                      radius: BorderRadius.circular(15)),
                                  AppSkoleton(
                                      width: size.width / 2,
                                      height: 10,
                                      margin: const EdgeInsets.only(bottom: 5),
                                      radius: BorderRadius.circular(15)),
                                ])),
                        Spacer(),
                        AppSkoleton(
                            width: 80,
                            height: 20,
                            margin:
                                const EdgeInsets.only(bottom: 15, right: 15),
                            radius: BorderRadius.circular(5))
                      ],
                    );
                  }));
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              hasError = true;
            });
            // executes after build
          });
          return SizedBox.shrink();
          // return Expanded(
          //   child: ListView.builder(
          //       physics: const BouncingScrollPhysics(),
          //       itemCount: 1,
          //       scrollDirection: Axis.vertical,
          //       itemBuilder: (ctx, index) {
          //         return Column(
          //           mainAxisSize: MainAxisSize.min,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Flexible(
          //                 child: Container(
          //               margin: const EdgeInsets.only(
          //                   bottom: 20, right: 15, left: 15, top: 64),
          //               width: 64,
          //               height: 64,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10),
          //                   image: DecorationImage(
          //                       image: AssetImage("assets/images/error.png"),
          //                       fit: BoxFit.cover)),
          //             )),
          //             Flexible(
          //                 child: Container(
          //               margin:
          //                   EdgeInsets.only(left: 15, right: 15, bottom: 16),
          //               child: Text(
          //                 "Essayons a nouveau de charger votre données",
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     fontSize: 20, fontWeight: FontWeight.bold),
          //               ),
          //             )),
          //             Flexible(
          //                 child: Container(
          //               margin:
          //                   EdgeInsets.only(left: 15, right: 15, bottom: 20),
          //               child: Text(
          //                 "une erreur s'est produit lors du chargement de vos données. Appuyer sur Réessayer pour charger a nouveau vos données.",
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     fontSize: 16,
          //                     height: 1.3,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             )),
          //             Flexible(
          //                 child: Container(
          //               margin:
          //                   EdgeInsets.only(left: 15, right: 15, bottom: 20),
          //               child: Text(
          //                 error.toString(),
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     fontSize: 16,
          //                     height: 1.3,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             )),
          //             Flexible(
          //                 child: Container(
          //                     width: 120,
          //                     height: 50,
          //                     child: TextButton(
          //                       child: Text("Réessayer",
          //                           style: TextStyle(
          //                               color: Colors.white,
          //                               fontSize: 16,
          //                               fontWeight: FontWeight.bold)),
          //                       style: ButtonStyle(
          //                         backgroundColor: MaterialStateProperty.all(
          //                             Color.fromARGB(255, 0, 87, 209)),
          //                       ),
          //                       onPressed: () {
          //                         search("");
          //                       },
          //                     )))
          //           ],
          //         );
          //       }),
          // );
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                hasError = true;
              });
              // executes after build
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                hasError = false;
              });
            });

            return Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 1,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Aucun résultat trouvé',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )
                        ],
                      );
                    }));
          }
          return Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (ctx, index) {
                    return searchList(snapshot.data![index], size);
                  }));
        }
        return Container();
      },
    );
  }

  Widget searchList(Map rslt, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
            onTap: () {
              // coursInfo.setCurretntCategory(allCategory.collection.categories.firstWhere((item) {
              //   int x = item.id;
              //   int y = cours.category;
              //   if (x == y) {
              //     return true;
              //   }
              //   return false;
              // }));
              //TODO:
              Rappel rap = Rappel();
              rap.nom = rslt["nom"].toLowerCase();
              Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => NameMedi(
                            animationController: widget.animationController,
                          )));
            },
            child: Container(
              decoration: BoxDecoration(),
              padding:
                  const EdgeInsets.only(left: 0, right: 15, top: 4, bottom: 4),
              margin: EdgeInsets.only(left: 25),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Text(
                            (rslt["nom"]).toLowerCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4),
                          width: size.width / 1.5,
                          child: Text(
                            rslt["forme"].toLowerCase(),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(
                            "${rslt["prix_BR"]} dh",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple,
                                height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )),
        Divider(
          height: 2,
          color: Colors.grey,
          indent: 25,
          endIndent: 0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var changes = Provider.of<HomeProvider>(context, listen: true);
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    return Scaffold(
      body: SlideTransition(
        position: _firstHalfAnimation,
        child: SlideTransition(
          position: _secondHalfAnimation,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 72),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: MediaQuery.of(context).size.height / 18,
                                child: TextField(
                                  controller: inputontroller,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  onChanged: search,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 242, 242, 242),
                                      contentPadding: const EdgeInsets.all(10),
                                      suffixIcon: const Icon(
                                        Icons.search,
                                        color:
                                            Color.fromARGB(255, 144, 144, 144),
                                        size: 24,
                                        textDirection: TextDirection.ltr,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      hintText:
                                          "veuillez tapez le nom de votre médicament",
                                      hintStyle: const TextStyle(
                                          letterSpacing: .5,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromARGB(
                                              255, 144, 144, 144))),
                                ),
                              )
                            ]),
                        //getCategoryUI(),
                      ],
                    )),
                inputontroller.text.isNotEmpty
                    ? searchResult()
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: hasError
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 5, top: MediaQuery.of(context).size.height * 0.1),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < 3; i++)
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 480),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: 0 == i
                                  ? Color(0xff132137)
                                  : Color(0xffE3E4E4),
                            ),
                            width: 10,
                            height: 10,
                          ),
                        ),
                    ],
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    Rappel rap = Rappel();
                    rap.nom = inputontroller.text;
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => NameMedi(
                          animationController: widget.animationController,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
