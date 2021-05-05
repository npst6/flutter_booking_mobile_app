/// Note file item_service.dart

import 'package:flutter/material.dart';

///ItemService StatelessWidget
class ItemService extends StatelessWidget {
  ///widget
  final Widget widget;

  ///title
  final String title;

  ItemService(
    this.widget,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      ///Container margin
      margin: const EdgeInsets.symmetric(horizontal: 5),

      ///Container width
      width: 50,

      ///Container height
      height: 50,

      child: Column(
        children: [
          ///widget
          widget,

          const SizedBox(
            height: 5,
          ),

          Text(
            ///Text
            title,

            style: TextStyle(
              ///Text weight
              fontWeight: FontWeight.w600,

              ///Text spacing
              letterSpacing: 1,
            ),

            ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
