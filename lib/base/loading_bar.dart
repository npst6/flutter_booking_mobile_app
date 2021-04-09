///Note file loading_bar.dart

import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter/material.dart';

///class LoadingBar extends StatelessWidget
class LoadingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height, ///Container height
      width: MediaQuery.of(context).size.width, ///Container width
      color: Colors.grey.withOpacity(.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, ///Using mainAxisAlignment in a Column will align its children vertically (top, bottom).
        children: [
          new CircularProgressIndicator(
            backgroundColor: Colors.transparent, ///background color
            valueColor: new AlwaysStoppedAnimation<Color>(AppColors.buttonColor), ///
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Loading...",
            style: TextStyle(
                color: AppColors.buttonColor, ///Text color
                fontWeight: FontWeight.w600,  ///Text weight
                letterSpacing: 1, ///Text spacing
            ),
          ),
        ],
      ),
    );
  }
}
