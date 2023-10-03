
import 'package:flutter/material.dart';

class MyStepper extends ChangeNotifier {
  int _currentPage = 3;
  int totalPages = 8;
  int get currentPage => _currentPage;

  MyStepper();

  void incriment() {
    _currentPage++;
    notifyListeners();
  }

  void deccriment() {
    _currentPage--;
    notifyListeners();
  }

  String stepper() => "$_currentPage/$totalPages";
}
