///Note file new_home_stay.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/app/my_home_stay/bloc/new_home_stay_bloc.dart';

///NewHomeStay StatefulWidget
class NewHomeStay extends StatefulWidget {
  @override
  _NewHomeStayState createState() => _NewHomeStayState();
}

/// _NewHomeStayState State<>
class _NewHomeStayState extends State<NewHomeStay> {
  ThemeData themeData;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerName;
  TextEditingController controllerPhone;
  TextEditingController controllerBankName;
  TextEditingController controllerNumberBank;
  TextEditingController controllerAccountBankName;
  final picker = ImagePicker();
  NewHomeStayBloc newHomeStayBloc;

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    newHomeStayBloc.newHomeStayStateStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pop(context);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    newHomeStayBloc = new NewHomeStayBloc();
    controllerPhone = new TextEditingController();
    controllerName = new TextEditingController();
    controllerBankName = new TextEditingController();
    controllerNumberBank = new TextEditingController();
    controllerAccountBankName = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newHomeStayBloc.dispose();
    super.dispose();
  }

  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.buttonColor,
              size: 15,
            ),
          ),
        ),
        centerTitle: true,
        titleSpacing: 1,
        title: Text(
          "New Home Stay".toUpperCase(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<File>(
                        stream: newHomeStayBloc.fileImageStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            file = snapshot.data;
                            return Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                    image: FileImage(
                                  snapshot.data,
                                )),
                              ),
                            );
                          } else
                            return Container(

                                ///Container height
                                height: 200,

                                ///Container width
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(.7),
                                      width: 2),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      showGetImage(context);
                                    },
                                    child: Icon(
                                      ///Icon
                                      Icons.image,

                                      ///Icon size
                                      size: 100,

                                      ///Icon color
                                      color: Colors.grey.withOpacity(.7),
                                    ),
                                  ),
                                ));
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                        ///Text size
                        fontSize: 15,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text weight
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    XTextFormField(
                      controller: controllerName,

                      ///Hint text
                      hintText: "Name",

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,
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
                      "Phone number",
                      style: TextStyle(
                        ///Text size
                        fontSize: 15,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text weight
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    XTextFormField(
                      controller: controllerPhone,

                      ///Hint text
                      hintText: "Phone",

                      ///Text type phone
                      textInputType: TextInputType.phone,

                      ///CHeck empty data
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: Icon(
                        ///Icon
                        Icons.phone,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Account Bank".toUpperCase(),
                        style: TextStyle(
                          ///Text size
                          fontSize: 18,

                          ///Text spacing
                          letterSpacing: 1.5,

                          ///Text weight
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: Divider(
                          height: 2,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Bank name",
                      style: TextStyle(
                        ///Text size
                        fontSize: 15,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text weight
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    XTextFormField(
                      controller: controllerBankName,

                      ///Hint text
                      hintText: "Bank name",

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: Icon(
                        ///Icon
                        Icons.comment_bank,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Account number",
                      style: TextStyle(
                        ///Text size
                        fontSize: 15,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text weight
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    XTextFormField(
                      controller: controllerNumberBank,

                      ///Hint text
                      hintText: "Number",

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,

                      ///Text type phone
                      textInputType: TextInputType.phone,
                      prefixIcon: Icon(
                        ///Icon
                        Icons.phone,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Account name",
                      style: TextStyle(
                        ///Text size
                        fontSize: 15,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text weight
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    XTextFormField(
                      controller: controllerAccountBankName,
                      hintText: "Account name",
                      prefixIcon: Icon(
                        ///Icon
                        Icons.drive_file_rename_outline,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
              stream: newHomeStayBloc.newHomeStayStateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == UIState.LOADING)
                  return LoadingBar();
                else
                  return Center();
              })
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
        child: XButton("Save", () {
          if (_formKey.currentState.validate()) {
            newHomeStayBloc.addHomeStay(
                file,
                controllerName.text,
                controllerPhone.text,
                controllerBankName.text,
                controllerNumberBank.text,
                controllerAccountBankName.text);
          }
        }),
      ),
    );
  }

  void showGetImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            ///Container height
            height: 100,

            ///Container width
            width: double.infinity,
            decoration: BoxDecoration(
              color: themeData.scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              ///Padding
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: XButton("Camera", () {
                    newHomeStayBloc.getImageByCamera(picker);
                  })),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: XButton("Library", () {
                    newHomeStayBloc.getImageByGallery(picker);
                  })),
                ],
              ),
            ),
          );
        });
  }
}