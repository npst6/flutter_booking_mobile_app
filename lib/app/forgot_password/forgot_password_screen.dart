///Note file forgot_password_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///class ForgotPassScreen extends StatefulWidget
class ForgotPassScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

///class _LoginScreenState extends State<ForgotPassScreen>
class _LoginScreenState extends State<ForgotPassScreen> {
  TextEditingController controllerEmail; ///
  final _formKey = GlobalKey<FormState>(); ///
  @override
  void initState() {
    controllerEmail = new TextEditingController(); ///
    super.initState(); ///
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, ///Background color
        elevation: 0, ///
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: AppColors.buttonColor), ///Icon, icon color of icon button
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      ///body
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 20), ///padding
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, ///Using mainAxisAlignment in a Column will align its children vertically.
            crossAxisAlignment: CrossAxisAlignment.start, ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
            children: [
              Center(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: AppColors.buttonColor, ///Text color
                      fontWeight: FontWeight.w900,  ///Text weight
                      letterSpacing: 1, ///Text spacing
                      fontSize: 35),  ///Text size
                ),
              ),

              SizedBox(
                height: 100,
              ),

              Text(
                "Your Email",
                style: TextStyle(
                  fontWeight: FontWeight.w600, ///Text weight
                  letterSpacing: 1, ///Text spacing
                  fontSize: 16, ///Text size
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Form(
                key: _formKey, ///
                child: MTextFormField(
                  hintText: "Enter your email (ex@gmail.com)", ///Hint text
                  controller: controllerEmail, ///
                  textInputType: TextInputType.emailAddress, ///
                  funcValidation: ValidateData.validEmail, ///Validate email
                  prefixIcon: Icon(
                    Icons.mail, ///Icon email in form
                    color: AppColors.buttonColor, ///Icon color in form
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 40,
              ),

              MButton("Send", () {
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
