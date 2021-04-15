///Note file x_button.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';

/// MButton StatelessWidget
class XButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color color;
  final double height;
  XButton(
    this.title,
    this.onTap, {

    ///Button height
    this.height = 55,

    ///Button color
    this.color = AppColors.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        ///Container height
        height: height,
        decoration: BoxDecoration(
          ///Color box
          color: color,

          ///Border box
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            ///Text toUpperCase
            title.toUpperCase(),
            style: TextStyle(
              ///Text weight
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
