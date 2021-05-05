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

///LoginScreen StatefulWidget
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

/// _LoginScreenState State<>
class _LoginScreenState extends State<LoginScreen> {
  ///controllerEmail
  TextEditingController controllerEmail;

  ///controllerPass
  TextEditingController controllerPass;

  ///_formKey
  final _formKey = GlobalKey<FormState>();

  ///loginBloc
  LoginBloc loginBloc;

  @override
  void initState() {
    ///loginBloc
    loginBloc = new LoginBloc();

    ///controllerPass
    controllerPass = new TextEditingController();

    ///controllerEmail
    controllerEmail = new TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loginBloc.loginStream.listen(
      (value) {
        if (value == UIState.SUCCESS) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomeScreen();
              },
            ),
          );
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///Background color
        backgroundColor: Colors.transparent,

        ///Elevation
        elevation: 0,
      ),

      ///Body
      body: Stack(
        ///Alignment
        alignment: Alignment.center,

        children: [
          Padding(
            ///Padding
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),

            child: SingleChildScrollView(
              child: Form(
                ///_formKey
                key: _formKey,

                child: Column(
                  ///Using mainAxisAlignment in a Column will align its children vertically.
                  mainAxisAlignment: MainAxisAlignment.center,

                  ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Center(
                      child: Text(
                        ///Text
                        "Booking Hotels",

                        style: TextStyle(
                          ///Text size
                          fontSize: 40,

                          ///Text color
                          color: AppColors.primaryColor,

                          ///Text weight
                          fontWeight: FontWeight.w900,

                          ///Text spacing
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 100,
                    ),

                    Text(
                      ///Text
                      "Username",

                      style: TextStyle(
                        ///Text weight
                        fontWeight: FontWeight.w600,

                        ///Text size
                        fontSize: 16,

                        ///Text spacing
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    ///Email box
                    XTextFormField(
                      ///controllerEmail
                      controller: controllerEmail,

                      ///Hint text
                      hintText: "Enter your email (ex@gmail.com)",

                      ///Text type email address
                      textInputType: TextInputType.emailAddress,

                      ///Check validate email
                      funcValidation: ValidateData.validEmail,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon email box
                        Icons.person,

                        ///Icon color
                        color: AppColors.primaryColor,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      ///Text
                      "Password",

                      style: TextStyle(
                        ///Text spacing
                        letterSpacing: 1,

                        ///Text size
                        fontSize: 16,

                        ///Text weight
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    ///Password box
                    XTextFormField(
                      ///controllerPass
                      controller: controllerPass,

                      ///obscureText
                      obscureText: true,

                      ///Hint text
                      hintText: "Enter your password",

                      ///Check empty field
                      funcValidation: ValidateData.validPassword,

                      prefixIcon: Icon(
                        ///Icon password box
                        Icons.lock,

                        ///Icon color
                        color: AppColors.primaryColor,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    Align(
                      ///Alignment
                      alignment: Alignment.centerRight,

                      child: GestureDetector(
                        ///onTap
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPassScreen();
                              },
                            ),
                          );
                        },

                        child: Text(
                          ///Text
                          "Forgot Password ?",

                          style: TextStyle(
                            ///Text size
                            fontSize: 15,

                            ///Text color
                            color: AppColors.primaryColor,

                            ///Text weight
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    ///Login button
                    XButton(
                      "Login",
                      () {
                        if (_formKey.currentState.validate()) {
                          loginBloc.login(
                            ///email
                            email: controllerEmail.text,

                            ///pass
                            pass: controllerPass.text,
                          );
                        }
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Center(
                      child: Text(
                        ///Text
                        " or ",

                        style: TextStyle(
                          ///Text color
                          color: Colors.grey,

                          ///Text size
                          fontSize: 15,

                          ///Text weight
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    ///Register button
                    XButton(
                      "Register",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
            stream: loginBloc.loginStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING)
                return LoadingBar();
              else
                return Center();
            },
          ),
        ],
      ),
    );
  }
}
