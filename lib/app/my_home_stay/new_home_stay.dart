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
  ///themeData
  ThemeData themeData;

  ///_formKey
  final _formKey = GlobalKey<FormState>();

  ///controllerName
  TextEditingController controllerName;

  ///controllerPhone
  TextEditingController controllerPhone;

  ///controllerBankName
  TextEditingController controllerBankName;

  ///controllerNumberBank
  TextEditingController controllerNumberBank;

  ///controllerAccountBankName
  TextEditingController controllerAccountBankName;

  ///picker
  final picker = ImagePicker();

  ///newHomeStayBloc
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

  ///file
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///backgroundColor
        backgroundColor: themeData.scaffoldBackgroundColor,

        ///elevation
        elevation: 0,

        leading: GestureDetector(
          ///onTap
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            ///Padding
            padding: const EdgeInsets.all(10),

            child: Icon(
              ///Icon
              Icons.arrow_back_ios,

              ///Icon color
              color: AppColors.primaryColor,

              ///Icon size
              size: 15,
            ),
          ),
        ),

        ///Title center
        centerTitle: true,

        ///Title spacing
        titleSpacing: 1,

        ///Title
        title: Text(
          ///Text
          "New Home Stay".toUpperCase(),

          style: TextStyle(
            ///Text color
            // ignore: deprecated_member_use
            color: themeData.textSelectionColor,

            ///Text size
            fontSize: 20,

            ///Text weight
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      ///Body
      body: Stack(
        children: [
          Padding(
            ///Padding
            padding: const EdgeInsets.all(15),

            child: SingleChildScrollView(
              child: Form(
                ///_formKey
                key: _formKey,

                child: Column(
                  ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    StreamBuilder<File>(
                      stream: newHomeStayBloc.fileImageStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          file = snapshot.data;
                          return Container(
                            ///Container height
                            height: 200,

                            ///Container width
                            width: double.infinity,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                image: FileImage(
                                  snapshot.data,
                                ),
                              ),
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
                                  color: Colors.grey.withOpacity(.7), width: 2),
                            ),

                            child: Center(
                              child: GestureDetector(
                                ///onTap
                                onTap: () {
                                  showGetImage(context);
                                },

                                child: Icon(
                                  ///Icon
                                  Icons.image,

                                  ///Icon size
                                  size: 200,

                                  ///Icon color
                                  color: Colors.grey.withOpacity(.7),
                                ),
                              ),
                            ),
                          );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      ///Text
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
                      ///controllerName
                      controller: controllerName,

                      ///Hint text
                      hintText: "Input Name of Home Stay",

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon
                        Icons.home_filled,

                        ///Icon color
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      ///Text
                      "Contact",

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
                      ///controllerPhone
                      controller: controllerPhone,

                      ///Hint text
                      hintText: "Input Phone Number of Home Stay",

                      ///Text type phone
                      textInputType: TextInputType.phone,

                      ///CHeck empty data
                      funcValidation: ValidateData.validEmpty,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon
                        Icons.smartphone,

                        ///Icon color
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        ///Text, toUpperCase
                        ///
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
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        ///width
                        width: 200,

                        child: Divider(
                          ///height
                          height: 2,

                          ///color
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      ///Text
                      "Bank Name".toUpperCase(),

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
                      ///controllerBankName
                      controller: controllerBankName,

                      ///Hint text
                      hintText: "Input Name of Bank",

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon
                        Icons.comment_bank,

                        ///Icon color
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      ///Text
                      "Bank Account Number".toUpperCase(),

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
                      ///controllerNumberBank
                      controller: controllerNumberBank,

                      ///Hint text
                      hintText: "Input Number of Bank Account",

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,

                      ///Text type phone
                      textInputType: TextInputType.phone,

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon
                        Icons.confirmation_number,

                        ///Icon color
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      ///Text
                      "Bank Account Name".toUpperCase(),

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
                      ///controllerAccountBankName
                      controller: controllerAccountBankName,

                      ///hintText
                      hintText: "Input Name of Bank Account",

                      ///prefixIcon
                      prefixIcon: Icon(
                        ///Icon
                        Icons.perm_contact_cal,

                        ///Icon color
                        color: AppColors.primaryColor,
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
            },
          )
        ],
      ),
      bottomNavigationBar: Padding(
        ///Padding
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),

        child: XButton(
          "Save",
          () {
            if (_formKey.currentState.validate()) {
              newHomeStayBloc.addHomeStay(
                file,
                controllerName.text,
                controllerPhone.text,
                controllerBankName.text,
                controllerNumberBank.text,
                controllerAccountBankName.text,
              );
            }
          },
        ),
      ),
    );
  }

  ///showGetImage
  void showGetImage(BuildContext context) {
    showModalBottomSheet(
      ///context
      context: context,

      ///isScrollControlled
      isScrollControlled: true,

      ///backgroundColor
      backgroundColor: Colors.transparent,

      ///builder
      builder: (context) {
        return Container(
          ///Container height
          height: 100,

          ///Container width
          width: double.infinity,

          decoration: BoxDecoration(
            ///Color box
            color: themeData.scaffoldBackgroundColor,

            ///Border box
            borderRadius: BorderRadius.only(
              ///topLeft
              topLeft: Radius.circular(10),
              ///topRight
              topRight: Radius.circular(10),
            ),
          ),

          child: Padding(
            ///Padding
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

            child: Row(
              children: [
                Expanded(
                  child: XButton(
                    "Camera",
                    () {
                      newHomeStayBloc.getImageByCamera(picker);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: XButton(
                    "Library",
                    () {
                      newHomeStayBloc.getImageByGallery(picker);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
