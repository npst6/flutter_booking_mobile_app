///Note file permission_user.dart

import 'item_active_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/model/item_model.dart';
import 'package:flutter_booking_mobile_app/app/admin/bloc/admin_bloc.dart';

///PermissionUser  StatefulWidget
class PermissionUser extends StatefulWidget {
  final Account account;
  final AdminBloc adminBloc;
  PermissionUser(this.account, this.adminBloc);
  @override
  _PermissionUserState createState() => _PermissionUserState();
}

/// _PermissionUserState State<>
class _PermissionUserState extends State<PermissionUser> {
  int isActive;
  int permission;
  ItemModel initItem;
  @override
  void initState() {
    isActive = widget.account.isActive;
    permission = widget.account.permission;
    if (permission == 1) {
      initItem = ItemModel(id: '1', name: "User");
    } else {
      initItem = ItemModel(id: '0', name: "Admin");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      ///Container height
      height: 220,

      ///Container width
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        ///Color box
        color: Colors.white,

        ///Border box
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            ///Container height
            height: 50,

            ///Container weight
            width: double.infinity,
            decoration: BoxDecoration(
              ///Color box
              color: AppColors.primaryColor,

              ///Border box
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                ///Text
                "Permission",
                style: TextStyle(
                  ///Text size
                  fontSize: 17,

                  ///Text weight
                  fontWeight: FontWeight.w600,

                  ///Text spacing
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              ///Padding
              padding: const EdgeInsets.all(15),
              child: Column(
                ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ///Text
                    "Permission user",
                    style: TextStyle(
                      ///Text size
                      fontSize: 15,

                      ///Text weight
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ItemActiveUser(
                    title: "Active user",
                    initVal: widget.account.permission,
                    callBack: (val) {
                      if (val) {
                        permission = 1;
                      } else {
                        permission = 0;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  ///Save button
                  XButton(
                    "Save",
                    () {
                      widget.adminBloc
                          .updatePermission(widget.account.uid, permission);
                      Navigator.pop(context);
                    },
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
