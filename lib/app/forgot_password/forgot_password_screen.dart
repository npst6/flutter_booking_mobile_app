///Note file forgot_password_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///ForgotPassScreen StatefulWidget
class ForgotPassScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

/// _LoginScreenState State<>
class _LoginScreenState extends State<ForgotPassScreen> {
  TextEditingController controllerEmail;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    controllerEmail = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///Background color
        backgroundColor: Colors.transparent,

        ///Elevation
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              ///Icon
              Icons.keyboard_backspace,

              ///Icon color
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),

      ///body
      body: Padding(
        ///Padding
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            ///Using mainAxisAlignment in a Column will align its children vertically.
            mainAxisAlignment: MainAxisAlignment.center,

            ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  ///Text
                  "Forgot Password",
                  style: TextStyle(
                    ///Text size
                    fontSize: 35,

                    ///Text spacing
                    letterSpacing: 1,

                    ///Text weight
                    fontWeight: FontWeight.w900,

                    ///Text color
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                ///Text
                "Your Email",
                style: TextStyle(
                  ///Text size
                  fontSize: 16,

                  ///Text spacing
                  letterSpacing: 1,

                  ///Text weight
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: XTextFormField(
                  controller: controllerEmail,

                  ///Hint text
                  hintText: "Enter your email (ex@gmail.com)",

                  ///Text type email address
                  textInputType: TextInputType.emailAddress,

                  ///Validate email
                  funcValidation: ValidateData.validEmail,

                  prefixIcon: Icon(
                    ///Icon
                    Icons.mail,

                    ///Icon color
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
              ),

              ///Send button
              XButton("Send", () {
                if (_formKey.currentState.validate()) {
                  FirAuth().forgotPassWordByEmail(
                      controllerEmail.text, () {}, (val) {});
                }
              }),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
