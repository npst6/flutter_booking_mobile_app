///Note file no_fount.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';

///NoFoundWidget StatelessWidget
class NoFoundWidget extends StatelessWidget {
  ///title
  final String title;

  NoFoundWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      ///Container width
      width: double.infinity,

      ///Container height
      height: double.infinity,

      child: Column(
        ///Using mainAxisAlignment in a Column will align its children vertically.
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            ///Container width
            width: 150,

            ///Container height
            height: 100,

            decoration: BoxDecoration(
              image: DecorationImage(
                ///Image
                image: AssetImage(
                  "assets/images/logo2.png",
                ),

                ///Image fit
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            ///Text
            title,

            ///Text align
            textAlign: TextAlign.center,

            style: TextStyle(
              ///Text color
              color: AppColors.buttonColor,

              ///Text size
              fontSize: 15,

              ///Text weight
              fontWeight: FontWeight.w600,

              ///Text spacing
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
