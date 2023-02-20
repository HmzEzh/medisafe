import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int selectedDay = DateTime.now().day;
  int oldSelectedDay = DateTime.now().day;
  void setSelectedDay(int x) {
    oldSelectedDay = selectedDay;
    selectedDay = x;
    notifyListeners();
  }

  int getSelectedDay() {
    return selectedDay;
  }
  int getOldSelectedDay() {
    return oldSelectedDay;
  }
}
