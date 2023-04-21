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
    try{
      return DateTime.parse('$selectedYear-0$selectedMonth-$selectedDay');
    }catch(e){
      return DateTime.parse('$selectedYear-$selectedMonth-$selectedDay');
    }
    
    
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
    print(selectedDay);
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
