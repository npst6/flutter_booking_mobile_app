///Note file theme.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';

///ChangeNotifier
class ThemeChanger with ChangeNotifier {
  ThemeData themeData;              ///
  ThemeChanger ({this.themeData});  ///
  getTheme() => themeData;  ///Get theme = themeData ///one-line function

  ///Set theme
  setTheme (int dark) {
    if (dark == 0) {
      ///Describe dark theme
      themeData = ThemeData.dark().copyWith (
          primaryColor: AppColors.buttonColor,    ///Color of the main banner
          accentColor: AppColors.buttonColor,     ///Color
          scaffoldBackgroundColor: Colors.black,  ///Light background
          // ignore: deprecated_member_use
          textSelectionColor: Colors.white,       ///Text color
      );
    } else {
      ///Describe light theme
      themeData = ThemeData.light().copyWith (
          primaryColor: AppColors.buttonColor,    ///Color of the main banner
          accentColor: AppColors.buttonColor,     ///Color
          scaffoldBackgroundColor: Colors.white,  ///Light background
          // ignore: deprecated_member_use
          textSelectionColor: Colors.black,       ///Text color
      );
    }
    notifyListeners();                            ///
  }
}