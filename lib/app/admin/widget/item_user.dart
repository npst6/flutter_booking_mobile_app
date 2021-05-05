///Note file item_user.dart

import 'package:flutter_booking_mobile_app/app/admin/bloc/admin_bloc.dart';
import 'package:flutter_booking_mobile_app/app/admin/widget/permission_user.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter/material.dart';

///ItemUser StatelessWidget
class ItemUser extends StatelessWidget {
  ///themeData
  final ThemeData themeData;

  ///account
  final Account account;

  ///adminBloc
  final AdminBloc adminBloc;

  ItemUser(this.themeData, {this.account, this.adminBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      ///Container height
      height: 150,

      ///Container margin
      margin: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        ///Color box
        color: themeData.scaffoldBackgroundColor,

        ///Border box
        borderRadius: BorderRadius.circular(10),

        ///boxShadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            ///Flex
            flex: 1,

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),

                ///Image
                image: DecorationImage(
                  ///Image
                  image: AssetImage('assets/images/travel.png'),

                  ///Image fit
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            ///Flex
            flex: 3,

            child: Padding(
              ///Padding
              padding: const EdgeInsets.all(10),

              child: Column(
                ///Using mainAxisAlignment in a Column will align its children vertically.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Expanded(
                        ///Flex
                        flex: 5,

                        child: Text(
                          ///Text
                          account.name.toUpperCase(),

                          ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                          maxLines: 1,

                          style: TextStyle(
                            ///Text weight
                            fontWeight: FontWeight.w900,

                            ///Text size
                            fontSize: 16,

                            ///Text spacing
                            letterSpacing: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          ///onTap
                          onTap: () {
                            showEditPermission(context);
                          },

                          child: Icon(
                            ///Icon
                            Icons.more_vert,

                            ///Icon color
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        ///Text
                        "Email:",

                        ///Text align
                        textAlign: TextAlign.start,

                        ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                        maxLines: 1,

                        style: TextStyle(
                          ///Text weight
                          fontWeight: FontWeight.w700,

                          ///Text size
                          fontSize: 16,

                          ///Text spacing
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          ///Text
                          account.email,

                          ///Text align
                          textAlign: TextAlign.start,

                          ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                          maxLines: 1,

                          ///Use the ... sign to indicate overflow of text
                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            ///Text size
                            fontSize: 16,

                            ///Text style
                            fontStyle: FontStyle.italic,

                            ///Text spacing
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        ///Text
                        "Phone:",

                        ///Text align
                        textAlign: TextAlign.start,

                        ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                        maxLines: 1,

                        style: TextStyle(
                          ///Text weight
                          fontWeight: FontWeight.w700,

                          ///Text size
                          fontSize: 16,

                          ///Text spacing
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        ///Text
                        account.phone,

                        ///Text align
                        textAlign: TextAlign.start,

                        ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                        maxLines: 1,

                        ///Use the ... sign to indicate overflow of text
                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          ///Text size
                          fontSize: 16,

                          ///Text style
                          fontStyle: FontStyle.italic,

                          ///Text spacing
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        ///Text
                        "Create:",

                        ///Text align
                        textAlign: TextAlign.start,

                        ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                        maxLines: 1,

                        style: TextStyle(
                          ///Text weight
                          fontWeight: FontWeight.w700,

                          ///Text size
                          fontSize: 16,

                          ///Text spacing
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        ///Text
                        "04/05/2021",

                        ///Text align
                        textAlign: TextAlign.start,

                        ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                        maxLines: 1,

                        ///Use the ... sign to indicate overflow of text
                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          ///Text size
                          fontSize: 16,

                          ///Text style
                          fontStyle: FontStyle.italic,

                          ///Text spacing
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///Show edit permission
  void showEditPermission(BuildContext context) {
    showModalBottomSheet(
      ///context
      context: context,

      ///backgroundColor
      backgroundColor: Colors.transparent,

      builder: (BuildContext _) {
        return Center(child: PermissionUser(account, adminBloc));
      },

      ///isScrollControlled
      isScrollControlled: true,
    );
  }
}
