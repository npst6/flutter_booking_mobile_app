///Note file login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/app/home/home_screen.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/app/login/bloc/login_bloc.dart';
import 'package:flutter_booking_mobile_app/app/register/register_screen.dart';
import 'package:flutter_booking_mobile_app/app/forgot_password/forgot_password_screen.dart';
// import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///class LoginScreen extends StatefulWidget
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

///class _LoginScreenState extends State<LoginScreen>
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerEmail; ///
  TextEditingController controllerPass; ///
  final _formKey = GlobalKey<FormState>(); ///
  LoginBloc loginBloc; ///
  @override
  void initState() {
    loginBloc = new LoginBloc(); ///
    controllerPass = new TextEditingController(); ///
    controllerEmail = new TextEditingController(); ///
    super.initState(); ///
  }

  @override
  void didChangeDependencies() {
    loginBloc.loginStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    loginBloc.dispose(); ///
    super.dispose(); ///
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, ///
        elevation: 0, ///
      ),
      body: Stack(
        alignment: Alignment.center, ///
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 10), ///padding
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, ///Using mainAxisAlignment in a Column will align its children vertically.
                  crossAxisAlignment: CrossAxisAlignment.start, ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  children: [
                    Center(
                      child: Text(
                        "Booking Hotels",
                        style: TextStyle(
                            color: AppColors.buttonColor, ///Text color
                            fontWeight: FontWeight.w900, ///Text weight
                            letterSpacing: 1, ///Text spacing
                            fontSize: 40, ///Text size
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 100,
                    ),

                    Text(
                      "Username",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, ///Text weight
                          letterSpacing: 1, ///Text spacing
                          fontSize: 16, ///Text size
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    ///Email box
                    XTextFormField(
                      hintText: "Enter your email (ex@gmail.com)", ///Hint text
                      controller: controllerEmail, ///
                      textInputType: TextInputType.emailAddress, ///
                      funcValidation: ValidateData.validEmail, ///Check validate email
                      prefixIcon: Icon(
                        Icons.person, ///Icon email box
                        color: AppColors.buttonColor, ///Icon color
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600, ///Text weight
                        letterSpacing: 1, ///Text spacing
                        fontSize: 16, ///Text size
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    ///Password box
                    XTextFormField(
                      hintText: "Enter your password", ///Hint text
                      controller: controllerPass, ///
                      funcValidation: ValidateData.validEmpty, ///Check empty field
                      obscureText: true, ///
                      prefixIcon: Icon(
                        Icons.lock, ///Icon password box
                        color: AppColors.buttonColor, ///Icon color
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    Align(
                      alignment: Alignment.centerRight, ///
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return ForgotPassScreen();
                              }));
                        },
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                              color: AppColors.buttonColor, ///Text color
                              fontWeight: FontWeight.w400, ///Text weight
                              fontSize: 15, ///Text size
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    ///Login button
                    XButton("Login", () {
                      if (_formKey.currentState.validate()) {
                        loginBloc.login(
                            email: controllerEmail.text,
                            pass: controllerPass.text);
                      }
                    }),

                    SizedBox(
                      height: 15,
                    ),

                    Center(
                      child: Text(
                        " or ",
                        style: TextStyle(
                            color: Colors.grey, ///Text color
                            fontWeight: FontWeight.w400, ///Text weight
                            fontSize: 15, ///Text size
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    ///Register button
                    XButton(
                        "Register",
                            () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return RegisterScreen();
                              })
                          );
                    }),
                  ],
                ),
              ),
            ),
          ),

          StreamBuilder<UIState>(
              stream: loginBloc.loginStream, ///
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
