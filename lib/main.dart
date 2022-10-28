///Note file main.dart

import 'package:flutter/material.dart';
import 'app/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';

///Void main
void main() {
  ///The WidgetFlutterBinding is used to interact with the Flutter engine.
  ///Firebase.initializeApp() needs to call native code to initialize Firebase,
  ///and since the plugin needs to use platform channels to call the native code,
  ///which is done asynchronously therefore have to call ensureInitialized()
  ///to make sure that have an instance of the WidgetsBinding.
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

///MyApp StatelessWidget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      ///ChangeNotifierProvider is a subclass of ListenableProvider made for ChangeNotifier.
      ///It listens for changes in the model object.
      ///It rebuilds the dependents widgets whenever ChangeNotifier.notifyListeners is called.
      ///Listen if theme has changed
      create: (_) => ThemeChanger(
        themeData: ThemeData.light().copyWith(
          ///Color of the main banner
          primaryColor: AppColors.primaryColor,

          ///Background color
          scaffoldBackgroundColor: Colors.white,

          ///Text color
          // ignore: deprecated_member_use
          textSelectionColor: Colors.black,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: AppColors.primaryColor),
        ),
      ),

      child: MyAppTheme(),
    );
  }
}

///MyAppTheme StatelessWidget
class MyAppTheme extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ///theme
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      ///Don't show debug banner
      debugShowCheckedModeBanner: false,

      ///Get theme
      theme: theme.getTheme(),

      ///Home
      home: SplashScreen(),
    );
  }
}
