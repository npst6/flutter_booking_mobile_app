///Note file item_active_user.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';

///ItemActiveUser StatefulWidget
class ItemActiveUser extends StatefulWidget {
  ///callBack
  final Function callBack;

  ///title
  final String title;

  ///initVal
  final int initVal;

  ItemActiveUser({this.callBack, this.title, this.initVal});

  @override
  _ItemActiveUserState createState() => _ItemActiveUserState();
}

/// _ItemActiveUserState State<>
class _ItemActiveUserState extends State<ItemActiveUser> {
  ///isActive
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
        const SizedBox(
          width: 20,
        ),
        CupertinoSwitch(
          ///activeColor
          activeColor: AppColors.primaryColor,

          ///value
          value: isActive,

          ///onChanged
          onChanged: (v) {
            setState(() {
              ///isActive
              isActive = v;
            });
            widget.callBack(v);
          },
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          ///Text
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
