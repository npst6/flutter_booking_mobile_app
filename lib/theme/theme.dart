///Note file theme.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';

///ChangeNotifier
class ThemeChanger with ChangeNotifier {
  ///Theme - ThemeData
  ThemeData themeData;

  ///ThemeChanger - ThemeData
  ThemeChanger({this.themeData});

  ///Get theme = themeData ///one-line function
  getTheme() => themeData;

  ///Set theme
  setTheme(int dark) {
    if (dark == 0) {
      ///Describe dark theme
      themeData = ThemeData.dark().copyWith(
        ///Color of the main banner
        primaryColor: AppColors.buttonColor,

        ///Color
        accentColor: AppColors.buttonColor,

        ///Light background
        scaffoldBackgroundColor: Colors.black,

        ///Text color
        // ignore: deprecated_member_use
        textSelectionColor: Colors.white,
      );
    } else {
      ///Describe light theme
      themeData = ThemeData.light().copyWith(
        ///Color of the main banner
        primaryColor: AppColors.buttonColor,

        ///Color
        accentColor: AppColors.buttonColor,

        ///Light background
        scaffoldBackgroundColor: Colors.white,

        ///Text color
        // ignore: deprecated_member_use
        textSelectionColor: Colors.black,
      );
    }

    ///notifyListeners()
    notifyListeners();
  }
}
