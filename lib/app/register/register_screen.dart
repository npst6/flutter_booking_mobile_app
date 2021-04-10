///Note of register_screen.dart

import 'bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/app/home/home_screen.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';

///class RegisterScreen extends StatefulWidget
class RegisterScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

///class _LoginScreenState extends State<RegisterScreen>
class _LoginScreenState extends State<RegisterScreen> {
  TextEditingController controllerEmail; ///
  TextEditingController controllerPass; ///
  TextEditingController controllerPhone; ///
  TextEditingController controllerName; ///
  RegisterBloc registerBloc; ///

  final _formKey = GlobalKey<FormState>(); ///

  @override
  void initState() {
    registerBloc = new RegisterBloc();
    controllerPass = new TextEditingController();
    controllerEmail = new TextEditingController();
    controllerPhone = new TextEditingController();
    controllerName = new TextEditingController();
    super.initState();
  }

  ///Note
  @override
  void dispose() {
    registerBloc.dispose(); ///
    super.dispose(); ///
  }

  ///Note
  @override
  void didChangeDependencies() {
    registerBloc.registerStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pushReplacement(context, ///
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }), ///
        );
      }
    });
    super.didChangeDependencies(); ///
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///App bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, ///App bar background color
        elevation: 0, ///
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: AppColors.buttonColor), ///Icon, icon color in icon button
            onPressed: () {
              Navigator.pop(context); ///
            }),
      ),
      ///Body
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20), ///padding
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, ///Using mainAxisAlignment in a Column will align its children vertically.
                  crossAxisAlignment: CrossAxisAlignment.start, ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  children: [
                    Center(
                      child: Text(
                        "Register Account",
                        style: TextStyle(
                          color: AppColors.buttonColor, ///Text color
                          fontWeight: FontWeight.w900, ///Text weight
                          letterSpacing: 1, ///Text spacing
                          fontSize: 35, ///Text size
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ), ///Height between two fields

                    Text(
                      "Your Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w600, ///Text weight
                        letterSpacing: 1, ///Text spacing
                        fontSize: 16, ///Text size
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ), ///Height between two fields

                    MTextFormField(
                      hintText: "Enter your full name", ///Hint text in name box
                      controller: controllerName, ///
                      funcValidation: ValidateData.validEmpty, ///Check empty field
                      prefixIcon: Icon(
                        Icons.person, ///Icon in name box
                        color: AppColors.buttonColor, ///Icon color in name box
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ), ///Height between name box and email text

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
                    ), ///Height between email text and email box

                    MTextFormField(
                      hintText: "Enter your email (ex@gmail.com)", ///Hint text in email box
                      controller: controllerEmail, ///
                      textInputType: TextInputType.emailAddress, ///
                      funcValidation: ValidateData.validEmail, ///Validate email
                      prefixIcon: Icon(
                        Icons.mail, ///Icon in email box
                        color: AppColors.buttonColor, ///Icon color
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ), ///Height between email box and phone text

                    Text("Your Phone",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, ///Text weight
                          letterSpacing: 1, ///Text spacing
                          fontSize: 16, ///Text size
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ), ///Height between your phone text and phone box

                    MTextFormField(
                      hintText: "Enter your phone number", ///Hint text in phone box
                      funcValidation: ValidateData.validEmpty, ///
                      controller: controllerPhone, ///
                      textInputType: TextInputType.phone, ///
                      prefixIcon: Icon(
                        Icons.phone, ///Icon in phone box
                        color: AppColors.buttonColor, ///Icon color
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ), ///Height between phone box and password text

                    Text(
                      "Your Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, ///Text weight
                          letterSpacing: 1, ///Text spacing
                          fontSize: 16, ///Text size
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ), ///Height between password text and password box

                    MTextFormField(
                      hintText: "Enter your password", ///Hint text of password box
                      controller: controllerPass, ///
                      funcValidation: ValidateData.validEmpty, ///Check empty field
                      obscureText: true, ///
                      prefixIcon: Icon(
                        Icons.lock, ///Icon in password box
                        color: AppColors.buttonColor, ///
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ), ///Height between password box and register box

                    ///Register button
                    MButton("Register", () {
                      if (_formKey.currentState.validate()) {
                        registerBloc.register(
                          email: controllerEmail.text, ///Register email
                          pass: controllerPass.text, ///Register pass
                          name: controllerName.text, ///Register name
                          phone: controllerPhone.text, ///Register phone
                        );
                      }
                    }),

                    SizedBox(
                      height: 15,
                    ), ///Height between register button and page
                  ],
                ),
              ),
            ),
          ),

          ///
          StreamBuilder<UIState>(
              stream: registerBloc.registerStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == UIState.LOADING)
                  return LoadingBar();
                else
                  return Center();
              })
        ],
      ),
    );
  }
}
