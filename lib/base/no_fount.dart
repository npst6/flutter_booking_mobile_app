///Note file no_fount.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';

///NoFoundWidget StatelessWidget
class NoFoundWidget extends StatelessWidget {
  final String title; ///
  NoFoundWidget(this.title); ///
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,   ///Container width
      height: double.infinity,  ///Container height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,  ///
        children: [
          Container(
            width: 150,   ///Container width
            height: 100,  ///Container height
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/logo2.png",
                    ), ///Image
                    fit: BoxFit.cover,  ///Image fit
                ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          Text(
            title,
            textAlign: TextAlign.center,    ///
            style: TextStyle(
              color: AppColors.buttonColor, ///Text color
              fontSize: 15,                 ///Text size
              fontWeight: FontWeight.w600,  ///Text weight
              letterSpacing: 1,             ///Text spacing
            ),
          ),
        ],
      ),
    );
  }
}
