import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int oldSelectedDay = DateTime.now().day;

  bool anyChange = false;
  void setSelectedDay(int x) {
    oldSelectedDay = selectedDay;
    selectedDay = x;
    notifyListeners();
  }

  DateTime getCurentdate() {
    if (selectedDay > 9 && selectedMonth > 9) {
      return DateTime.parse('$selectedYear-$selectedMonth-$selectedDay');
    }
    if (selectedDay < 9 && selectedMonth < 9) {
      return DateTime.parse('$selectedYear-0$selectedMonth-0$selectedDay');
    }
    if (selectedDay < 9 && selectedMonth > 9) {
      return DateTime.parse('$selectedYear-$selectedMonth-0$selectedDay');
    }
    if (selectedDay > 9 && selectedMonth < 9) {
      return DateTime.parse('$selectedYear-0$selectedMonth-$selectedDay');
    }
    return DateTime.now();
  }

  DateTime getCurentdateB(String time) {
    if (selectedDay > 9 && selectedMonth > 9) {
      return DateTime.parse('$selectedYear-$selectedMonth-$selectedDay $time');
    }
    if (selectedDay < 9 && selectedMonth < 9) {
      return DateTime.parse('$selectedYear-0$selectedMonth-0$selectedDay $time');
    }
    if (selectedDay < 9 && selectedMonth > 9) {
      return DateTime.parse('$selectedYear-$selectedMonth-0$selectedDay $time');
    }
    if (selectedDay > 9 && selectedMonth < 9) {
      return DateTime.parse('$selectedYear-0$selectedMonth-$selectedDay $time');
    }
    return DateTime.now();
    
  }

  void setSelectedMonth(int x) {
    selectedMonth = x;
    notifyListeners();
  }

  void setSelectedYear(int x) {
    selectedYear = x;
    notifyListeners();
  }

  void setChanges() {
    anyChange = !anyChange;
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

  bool getChanges() {
    return anyChange;
  }
}
