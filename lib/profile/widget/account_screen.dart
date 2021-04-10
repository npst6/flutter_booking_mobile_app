///Note file account_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/profile/bloc/profile_bloc.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';


///class AccountScreen extends StatefulWidget
class AccountScreen extends StatefulWidget {
  final Color color; ///
  final Account account; ///
  final ProfileBloc profileBloc; ///
  AccountScreen(this.color, this.account, this.profileBloc);
  ///
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

///class _AccountScreenState extends State<AccountScreen>
class _AccountScreenState extends State<AccountScreen> {
  TextEditingController controllerEmail; ///
  TextEditingController controllerName; ///
  TextEditingController controllerPhone; ///
  TextEditingController controllerPass; ///

  @override
  void initState() {
    controllerEmail = new TextEditingController(text: widget.account.email);
    controllerPhone = new TextEditingController(text: widget.account.phone);
    controllerName = new TextEditingController(text: widget.account.name);
    controllerPass = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95, ///Container width
      height: 550, ///Container height
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), ///Color box shadow
            spreadRadius: 5, ///
            blurRadius: 7, ///
            offset: Offset(0, 3), /// changes position of shadow
          ),
        ],
        color: widget.color, ///Color box
        borderRadius: BorderRadius.circular(10), ///Border box
      ),

      child: Column(
        children: [
          Container(
            height: 50, ///Container height
            width: double.infinity, ///Container width
            decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                ),
            ),

            child: Center(
              child: Text(
                "Account",
                style: TextStyle(
                    fontSize: 17, ///Text size
                    fontWeight: FontWeight.w600, ///Text weight
                    letterSpacing: 1.2, ///Text spacing
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 15, ///Text size
                          fontWeight: FontWeight.w500, ///Text weight
                          letterSpacing: 1, ///Text spacing
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    MTextFormField(
                      controller: controllerEmail, ///
                      prefixIcon: Icon(
                        Icons.email, ///Icon email box
                        color: AppColors.buttonColor, ///Icon color
                      ),
                      enable: false, ///
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 15, ///Text size
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    MTextFormField(
                      controller: controllerName,
                      prefixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        color: AppColors.buttonColor,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      "Phone number",
                      style: TextStyle(
                        fontSize: 15, ///Text size
                        fontWeight: FontWeight.w500, ///Text weight
                        letterSpacing: 1, ///Text spacing
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    MTextFormField(
                      controller: controllerPhone, ///
                      prefixIcon: Icon(
                        Icons.phone, ///Icon phone box
                        color: AppColors.buttonColor, ///Icon color
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 15, ///Test size
                        fontWeight: FontWeight.w500, ///Text weight
                        letterSpacing: 1, ///Text spacing
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    MTextFormField(
                      controller: controllerPass, ///
                      prefixIcon: Icon(
                        Icons.vpn_key, ///Icon password box
                        color: AppColors.buttonColor, ///Icon color
                      ),
                      obscureText: true, ///
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ///Save button
                    MButton("Save", () {

                    })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
