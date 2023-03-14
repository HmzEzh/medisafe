import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int oldSelectedDay = DateTime.now().day;
  void setSelectedDay(int x) {
    oldSelectedDay = selectedDay;
    selectedDay = x;
    notifyListeners();
  }
  void setSelectedMonth(int x) {
  
    selectedMonth = x;
    notifyListeners();
  }
  void setSelectedYear(int x) {
    selectedYear = x;
    notifyListeners();
  }
  int getSelectedDay() {
    return selectedDay;
  }
  int getSelectedMonth() {
    return selectedMonth;
  }
  int getSelectedYear() {
    return selectedYear;
  }
  int getOldSelectedDay() {
    return oldSelectedDay;
  }
}
