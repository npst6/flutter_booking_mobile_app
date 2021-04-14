///Note file item_active_user.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';

///ItemActiveUser StatefulWidget
class ItemActiveUser extends StatefulWidget {
  final Function callBack;
  final String title;
  final int initVal;

  ItemActiveUser({this.callBack, this.title, this.initVal});

  @override
  _ItemActiveUserState createState() => _ItemActiveUserState();
}

/// _ItemActiveUserState State<>
class _ItemActiveUserState extends State<ItemActiveUser> {
  bool isActive;
  @override
  void initState() {
    if (widget.initVal == 1)
      isActive = true;
    else
      isActive = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ///Text
          "User",
          style: TextStyle(
            ///Text size
            fontSize: 15,

            ///Text weight
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        CupertinoSwitch(
            activeColor: AppColors.buttonColor,
            value: isActive,
            onChanged: (v) {
              setState(() {
                isActive = v;
              });
              widget.callBack(v);
            }),
        SizedBox(
          width: 20,
        ),
        Text(
          "Admin",
          style: TextStyle(
            ///Text size
            fontSize: 15,

            ///Text weight
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
