///Note file list_user_reviews.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';

///ListUserReviews StatelessWidget
// ignore: must_be_immutable
class ListUserReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      ///Container height
      height: 40,

      ///Container width
      width: double.infinity,

      child: Stack(
        children: list.map((e) {
          return list.indexOf(e) < 5
              ? Positioned(
                  left: list.indexOf(e) * 15.0,
                  child: itemUser(),
                )
              : list.indexOf(e) == 5
                  ? Positioned(
                      left: list.indexOf(e) * 15.0,
                      child: Container(
                        ///Container width
                        width: 30,

                        ///Container height
                        height: 30,

                        decoration: BoxDecoration(
                          ///Share box
                          shape: BoxShape.circle,

                          ///Color box
                          color: AppColors.primaryColor,
                        ),

                        child: Center(
                          child: Text(
                            ///Text
                            "${list.length - 5}+",

                            style: TextStyle(
                              ///Text weight
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox();
        }).toList(),
      ),
    );
  }

  Widget itemUser() {
    return Container(
      ///Container width
      width: 30,

      ///Container height
      height: 30,
      decoration: BoxDecoration(
        ///Shape box
        shape: BoxShape.circle,

        ///Image
        image: DecorationImage(
          ///Image
          image: AssetImage('assets/images/travel.png'),

          ///Image fit
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<int> list = [1, 23, 3, 4, 45, 4, 3, 2];
}
