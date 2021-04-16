///Note file account_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/app/profile/bloc/profile_bloc.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';

///AccountScreen StatefulWidget
class AccountScreen extends StatefulWidget {
  ///color
  final Color color;

  ///account
  final Account account;

  ///profileBloc
  final ProfileBloc profileBloc;

  AccountScreen(
    this.color,
    this.account,
    this.profileBloc,
  );

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

/// _AccountScreenState State<>
class _AccountScreenState extends State<AccountScreen> {
  ///controllerEmail
  TextEditingController controllerEmail;

  ///controllerName
  TextEditingController controllerName;

  ///controllerPhone
  TextEditingController controllerPhone;

  ///controllerPass
  TextEditingController controllerPass;

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
      ///Container height
      height: 550,

      ///Container width
      width: MediaQuery.of(context).size.width * 0.95,

      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],

        ///Color box
        color: widget.color,

        ///Border box
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children: [
          Container(
            ///Container height
            height: 50,

            ///Container width
            width: double.infinity,

            decoration: BoxDecoration(
              ///Color box
              color: AppColors.buttonColor,

              ///Border box
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),

            child: Center(
              child: Text(
                ///Text
                "Account",
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

              child: SingleChildScrollView(
                child: Column(
                  ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      ///Text
                      "Email",
                      style: TextStyle(
                        ///Text size
                        fontSize: 15,

                        ///Text weight
                        fontWeight: FontWeight.w500,

                        ///Text spacing
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      ///controllerEmail
                      controller: controllerEmail,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon email box
                        Icons.email,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                      enable: false,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      ///Text
                      "Name",
                      style: TextStyle(
                        ///Text size
                        fontSize: 15,

                        ///Text weight
                        fontWeight: FontWeight.w500,

                        ///Text spacing
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      ///controllerName
                      controller: controllerName,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon
                        Icons.drive_file_rename_outline,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      ///Text
                      "Phone number",
                      style: TextStyle(
                        ///Text size
                        fontSize: 15,

                        ///Text weight
                        fontWeight: FontWeight.w500,

                        ///Text spacing
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      ///controllerPhone
                      controller: controllerPhone,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon phone box
                        Icons.phone,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      ///Text
                      "Password",
                      style: TextStyle(
                        ///Test size
                        fontSize: 15,

                        ///Text weight
                        fontWeight: FontWeight.w500,

                        ///Text spacing
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      ///controllerPass
                      controller: controllerPass,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon password box
                        Icons.vpn_key,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ///Save button
                    XButton(
                      "Save",
                      () {
                        widget.profileBloc.updateInfoAccount(
                            controllerName.text,
                            controllerPhone.text,
                            controllerPass.text ?? "");
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
