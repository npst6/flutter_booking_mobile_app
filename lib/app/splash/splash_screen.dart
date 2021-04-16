///Note file splash_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_booking_mobile_app/utils/account_utils.dart';
import 'package:flutter_booking_mobile_app/app/home/home_screen.dart';
import 'package:flutter_booking_mobile_app/app/login/login_screen.dart';

///SplashScreen StatefulWidget
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// _SplashScreenState State<>
class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    prefs = await SharedPreferences.getInstance();
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
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Background color
      backgroundColor: Colors.white,

      body: Center(
        child: Container(
          ///Container width
          width: 200,

          ///Container height
          height: 200,

          decoration: BoxDecoration(
            image: DecorationImage(
              ///Assets image
              image: AssetImage('assets/images/logo2.png'),

              ///Image fit box
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
