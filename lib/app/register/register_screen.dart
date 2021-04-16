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

///RegisterScreen StatefulWidget
class RegisterScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

/// _LoginScreenState State<>
class _LoginScreenState extends State<RegisterScreen> {
  ///controllerEmail
  TextEditingController controllerEmail;

  ///controllerPass
  TextEditingController controllerPass;

  ///controllerPhone
  TextEditingController controllerPhone;

  ///controllerName
  TextEditingController controllerName;

  ///registerBloc
  RegisterBloc registerBloc;

  /// _formKey
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    registerBloc = new RegisterBloc();
    controllerPass = new TextEditingController();
    controllerEmail = new TextEditingController();
    controllerPhone = new TextEditingController();
    controllerName = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    registerBloc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    registerBloc.registerStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }),
        );
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///App bar
      appBar: AppBar(
        ///Background color
        backgroundColor: Colors.transparent,

        ///Elevation
        elevation: 0,

        leading: IconButton(
          ///Icon, icon color in icon button
          icon: Icon(
            ///Icon
            Icons.keyboard_backspace,

            ///Icon color
            color: AppColors.buttonColor,
          ),

          ///onPressed
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      ///Body
      body: Stack(
        children: [
          Padding(
            ///Padding
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),

            child: SingleChildScrollView(
              child: Form(
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
                        "Register Account",

                        style: TextStyle(
                          ///Text color
                          color: AppColors.buttonColor,

                          ///Text weight
                          fontWeight: FontWeight.w900,

                          ///Text spacing
                          letterSpacing: 1,

                          ///Text size
                          fontSize: 35,
                        ),
                      ),
                    ),

                    ///Height between two fields
                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      ///Text
                      "Your Name",
                      style: TextStyle(
                        ///Text weight
                        fontWeight: FontWeight.w600,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text size
                        fontSize: 16,
                      ),
                    ),

                    ///Height between two fields
                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      ///controllerName
                      controller: controllerName,

                      ///Hint text in name box
                      hintText: "Enter your full name",

                      ///Check empty field
                      funcValidation: ValidateData.validEmpty,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon in name box
                        Icons.person,

                        ///Icon color in name box
                        color: AppColors.buttonColor,
                      ),
                    ),

                    ///Height between name box and email text
                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      ///Text
                      "Your Email",

                      style: TextStyle(
                        ///Text weight
                        fontWeight: FontWeight.w600,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text size
                        fontSize: 16,
                      ),
                    ),

                    ///Height between email text and email box
                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      ///controllerEmail
                      controller: controllerEmail,

                      ///Hint text in email box
                      hintText: "Enter your email (ex@gmail.com)",

                      ///Input type email
                      textInputType: TextInputType.emailAddress,

                      ///Validate email
                      funcValidation: ValidateData.validEmail,

                      prefixIcon: Icon(
                        ///Icon in email box
                        Icons.mail,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                    ),

                    ///Height between email box and phone text
                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      ///Text
                      "Your Phone",

                      style: TextStyle(
                        ///Text weight
                        fontWeight: FontWeight.w600,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text size
                        fontSize: 16,
                      ),
                    ),

                    ///Height between your phone text and phone box
                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      ///controllerPhone
                      controller: controllerPhone,

                      ///Hint text in phone box
                      hintText: "Enter your phone number",

                      ///Check empty field
                      funcValidation: ValidateData.validEmpty,

                      ///Input type phone
                      textInputType: TextInputType.phone,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon in phone box
                        Icons.phone,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                    ),

                    ///Height between phone box and password text
                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      ///Text
                      "Your Password",

                      style: TextStyle(
                        ///Text weight
                        fontWeight: FontWeight.w600,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text size
                        fontSize: 16,
                      ),
                    ),

                    ///Height between password text and password box
                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      ///controllerPass
                      controller: controllerPass,

                      ///Hint text of password box
                      hintText: "Enter your password",

                      ///Check empty field
                      funcValidation: ValidateData.validEmpty,

                      ///obscureText
                      obscureText: true,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon in password box
                        Icons.lock,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                    ),

                    ///Height between password box and register box
                    const SizedBox(
                      height: 40,
                    ),

                    ///Register button
                    XButton(
                      "Register",
                      () {
                        if (_formKey.currentState.validate()) {
                          registerBloc.register(
                            ///Register email
                            email: controllerEmail.text,

                            ///Register pass
                            pass: controllerPass.text,

                            ///Register name
                            name: controllerName.text,

                            ///Register phone
                            phone: controllerPhone.text,
                          );
                        }
                      },
                    ),

                    ///Height between register button and page
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
            stream: registerBloc.registerStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING)
                return LoadingBar();
              else
                return Center();
            },
          )
        ],
      ),
    );
  }
}
