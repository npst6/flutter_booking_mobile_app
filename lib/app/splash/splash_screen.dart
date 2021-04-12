///Note file splash_screen.dart

import 'package:flutter_booking_mobile_app/app/home/home_screen.dart';
import 'package:flutter_booking_mobile_app/app/login/login_screen.dart';
import 'package:flutter_booking_mobile_app/utils/account_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///SplashScreen StatefulWidget
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState(); ///create state _SplashScreenState
}

/// _SplashScreenState State<>
class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences prefs; ///
  @override
  void initState() {
    super.initState(); ///
  }

  ///
  @override
  void didChangeDependencies() async {
    prefs = await SharedPreferences.getInstance();
    // final theme = Provider.of<ThemeChanger>(context);
    if (prefs.getString("uid") == null || prefs.getString("uid") == "") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
      AccountUtils().setAccount(uid1: prefs.getString("uid"));
    }
//    theme.setTheme(_theme);
    super.didChangeDependencies();
  }

  checkSharedPreferences() {
   // if (prefs.getInt("theme") == null) {
   //   _theme = 0;
   // } else {
   //   _theme = prefs.getInt("theme");
   // }
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, ///Background color
      body: Center(
        child: Container(
          width: 200, ///Container width
          height: 200, ///Container height
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo2.png'),
              fit: BoxFit.fitWidth, ///Image fit box
            ),
          ),
        ),
      ),
    );
  }
}
