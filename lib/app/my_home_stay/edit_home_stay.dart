///Note file edit_home_stay.dart

import 'dart:io';
import 'bloc/edit_home_stay_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/model/my_home_stay.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';

///EditHomeStay StatefulWidget
class EditHomeStay extends StatefulWidget {
  final MyHomeStay myHomeStay;
  EditHomeStay(this.myHomeStay);
  @override
  _NewHomeStayState createState() => _NewHomeStayState();
}

///_NewHomeStayState State<>
class _NewHomeStayState extends State<EditHomeStay> {
  ThemeData themeData;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerName;
  TextEditingController controllerPhone;
  TextEditingController controllerBankName;
  TextEditingController controllerNumberBank;
  TextEditingController controllerAccountBankName;
  final picker = ImagePicker();
  EditHomeStayBloc editHomeStayBloc;

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();

    editHomeStayBloc.editHomeStayStateStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pop(context);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    editHomeStayBloc = new EditHomeStayBloc();
    controllerPhone = new TextEditingController(text: widget.myHomeStay.phone);
    controllerName = new TextEditingController(text: widget.myHomeStay.name);
    controllerBankName =
        new TextEditingController(text: widget.myHomeStay.bankName);
    controllerNumberBank =
        new TextEditingController(text: widget.myHomeStay.bankNumber);
    controllerAccountBankName =
        new TextEditingController(text: widget.myHomeStay.accountNameBank);
    super.initState();
  }

  @override
  void dispose() {
    editHomeStayBloc.dispose();
    super.dispose();
  }

  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///Background color
        backgroundColor: themeData.scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            ///padding
            padding: const EdgeInsets.all(10),
            child: Icon(
              ///Icon
              Icons.arrow_back_ios,

              ///Icon size
              size: 15,

              ///Icon color
              color: AppColors.buttonColor,
            ),
          ),
        ),
        centerTitle: true,
        titleSpacing: 1,
        title: Text(
          "Edit Home Stay".toUpperCase(),
          style: TextStyle(
            ///Text size
            fontSize: 20,

            ///Text color
            color: Colors.black,

            ///Text weight
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                ///Icon
                Icons.delete,

                ///Icon color
                color: AppColors.buttonColor,
              ),
              onPressed: () {
                editHomeStayBloc.deleteHomeStay();
              }),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            ///Padding
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<File>(
                        stream: editHomeStayBloc.fileImageStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            file = snapshot.data;
                            return Container(
                              ///Container height
                              height: 200,

                              ///Container width
                              width: double.infinity,
                              decoration: BoxDecoration(
                                ///Border box
                                borderRadius: BorderRadius.circular(7),

                                ///Image
                                image: DecorationImage(
                                  ///Image
                                  image: FileImage(
                                    snapshot.data,
                                  ),

                                  ///Image fit
                                  fit: BoxFit.cover,
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
                                  ///Border box
                                  borderRadius: BorderRadius.circular(7),

                                  ///Image
                                  image: DecorationImage(
                                    ///Image
                                    image: NetworkImage(
                                      widget.myHomeStay.urlImage,
                                    ),

                                    ///Image fit
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Center(
                                    child: IconButton(
                                        icon: Icon(
                                          ///Icon
                                          Icons.camera_alt,

                                          ///Icon color
                                          color: Colors.grey.withOpacity(.6),
                                        ),
                                        onPressed: () {
                                          showGetImage(context);
                                        })));
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

                      ///Check empty data
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

                      ///Text type phone
                      textInputType: TextInputType.phone,

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: Icon(
                        ///Icon
                        Icons.confirmation_number,

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

                      ///Hint text
                      hintText: "Account name",

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
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
              stream: editHomeStayBloc.editHomeStayStateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == UIState.LOADING)
                  return LoadingBar();
                else
                  return Center();
              })
        ],
      ),
      bottomNavigationBar: Padding(
        ///Padding
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),

        ///Save button
        child: XButton("Save", () {
          if (_formKey.currentState.validate()) {
            if (file != null) {
              editHomeStayBloc.editHomeStayNotFile(
                  widget.myHomeStay.urlImage,
                  controllerName.text,
                  controllerPhone.text,
                  controllerBankName.text,
                  controllerNumberBank.text,
                  controllerAccountBankName.text);
            } else
              editHomeStayBloc.editHomeStayHaveFile(
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

        ///Background color
        backgroundColor: Colors.transparent,
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
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              ///Padding
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  ///Camera button
                  Expanded(
                      child: XButton("Camera", () {
                    editHomeStayBloc.getImageByCamera(picker);
                  })),
                  SizedBox(
                    width: 10,
                  ),

                  ///Library button
                  Expanded(
                      child: XButton("Library", () {
                    editHomeStayBloc.getImageByGallery(picker);
                  })),
                ],
              ),
            ),
          );
        });
  }
}
