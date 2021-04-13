///Note file item_details_tax.dart

import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter/material.dart';

///ItemDetailsTax StatelessWidget
class ItemDetailsTax extends StatelessWidget {
  final String title;
  final int number;
  final bool isShowNumber;
  final double price;
  ItemDetailsTax({
    this.title,
    this.number,
    this.isShowNumber = false,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          ///Flex
          flex: 5,
          child: Text(
            ///Text
            title,
            style: TextStyle(
              ///Text weight
              fontWeight: FontWeight.w600,

              ///Text size
              fontSize: 17,
            ),
          ),
        ),
        Expanded(
          ///Flex
          flex: 1,
          child: !isShowNumber
              ? SizedBox()
              : Text(
                  ///Text
                  "x$number",
                  style: TextStyle(
                    ///Text weight
                    fontWeight: FontWeight.w700,

                    ///Text size
                    fontSize: 16,
                  ),
                ),
        ),
        Expanded(
          ///Flex
          flex: 2,
          child: Text(
            ///Text
            "${price * number}\$",

            ///Text align
            textAlign: TextAlign.right,
            style: TextStyle(
              ///Text weight
              fontWeight: FontWeight.w700,

              ///Text size
              fontSize: 17,

              ///Text color
              color: price >= 0 ? null : AppColors.buttonColor.withOpacity(.6),
            ),
          ),
        ),
      ],
    );
  }
}
