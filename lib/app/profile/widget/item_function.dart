///Note file item_function.dart

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

///class ItemFunction extends StatelessWidget
class ItemFunction extends StatelessWidget {
  final Function onTap; ///
  final String title; ///
  final String urlSVG; ///
  final Color color; ///
  ItemFunction({this.onTap, this.title, this.urlSVG, this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10), ///padding
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(urlSVG, width: 20, color: color), ///

                  SizedBox(
                    width: 15,
                  ),

                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16, ///Text size
                        letterSpacing: 1, ///Text spacing
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios, ///Icon
              size: 18, ///Icon size
              color: Colors.grey, ///Icon color
            ),
          ],
        ),
      ),
    );
  }
}
