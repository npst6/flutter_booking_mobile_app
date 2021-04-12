/// Note file item_service.dart

import 'package:flutter/material.dart';

///ItemService StatelessWidget
class ItemService extends StatelessWidget {
  final Widget widget; ///
  final String title; ///
  ItemService(this.widget, this.title); ///
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5), ///

      width: 50,  ///Container width

      height: 50, ///Container height

      child: Column(
        children: [
          widget, ///

          SizedBox(
            height: 5,
          ),

          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,  ///Text weight
                letterSpacing: 1,             ///Text spacing
            ),
            maxLines: 1,                      ///
          ),
        ],
      ),
    );
  }
}
