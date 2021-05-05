///Note file flutter_show_toast.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///FlutterToast
class FlutterToast {
  void showToast(String title) {
    Fluttertoast.showToast(
      ///msg
      msg: title,

      ///toastLength
      toastLength: Toast.LENGTH_SHORT,

      ///gravity
      gravity: ToastGravity.BOTTOM,

      ///timeInSecForIosWeb
      timeInSecForIosWeb: 1,

      ///Background color
      backgroundColor: Colors.blue,

      ///Text size
      fontSize: 17.0,
    );
  }
}
