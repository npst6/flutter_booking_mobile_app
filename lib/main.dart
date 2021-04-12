///Note file main.dart

import 'package:flutter/material.dart';
import 'app/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';

///Void main
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
  ///The WidgetFlutterBinding is used to interact with the Flutter engine.
  ///Firebase.initializeApp() needs to call native code to initialize Firebase,
  ///and since the plugin needs to use platform channels to call the native code,
  ///which is done asynchronously therefore have to call ensureInitialized()
  ///to make sure that have an instance of the WidgetsBinding.
}

///MyApp  StatelessWidget
class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return ChangeNotifierProvider <ThemeChanger> (
      ///ChangeNotifierProvider is a subclass of ListenableProvider made for ChangeNotifier.
      ///It listens for changes in the model object.
      ///It rebuilds the dependents widgets whenever ChangeNotifier.notifyListeners is called.
      ///Listen if theme has changed
      ///
      create: (_) => ThemeChanger (
          themeData: ThemeData.light().copyWith (
            primaryColor: AppColors.buttonColor,    ///Color of the main banner
            accentColor: AppColors.buttonColor,     ///Color
            scaffoldBackgroundColor: Colors.white,  ///Background color
            // ignore: deprecated_member_use
            textSelectionColor: Colors.black,       ///Text color
          ),
      ),
      child: MyAppTheme(),
    );
  }
}

///class MyAppTheme extends StatelessWidget
class MyAppTheme extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context); ///
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),                        ///
      home: SplashScreen(),                           ///
    );
  }
}