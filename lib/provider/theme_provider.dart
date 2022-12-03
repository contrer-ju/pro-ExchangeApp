import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  bool darkThemeSelected =
      Hive.box('darkThemeSelectedBox').get('value') ?? false;
  bool englishOption = Hive.box('englishOptionBox').get('value') ?? false;

  ThemeData currentTheme() {
    return darkThemeSelected ? customDarkTheme : customLightTheme;
  }

  void switchTheme() {
    darkThemeSelected = !darkThemeSelected;
    notifyListeners();
  }

  void saveTheme() {
    Hive.box('darkThemeSelectedBox').put('value', darkThemeSelected);
  }

  void switchLanguage() {
    englishOption = !englishOption;
    notifyListeners();
  }

  void saveLanguage() {
    Hive.box('englishOptionBox').put('value', englishOption);
  }
}
