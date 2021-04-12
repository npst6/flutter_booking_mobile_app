///Note file new_room.dart

import 'dart:io';
import 'bloc/new_room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/model/item_model.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/base/text_field_choose.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter_booking_mobile_app/remote/province_response/province_response.dart';

/// Class NewRoom extends StatefulWidget
class NewRoom extends StatefulWidget {
  @override
  _NewRoomState createState() => _NewRoomState();
}

/// Class _NewRoomState extends State
class _NewRoomState extends State<NewRoom> {
  ThemeData themeData; ///
  final _formKey = GlobalKey<FormState>(); ///
  TextEditingController controllerName; ///
  TextEditingController controllerDesc; ///
  TextEditingController controllerAddress; ///
  TextEditingController controllerFreeTime; ///
  TextEditingController controllerCity; ///
  int child;
  int adults;
  TextEditingController controllerPrice;
  TextEditingController controllerDiscountPercent;
  String startDay;
  String endDay;
  final picker = ImagePicker();
  NewRoomBloc newRoomBloc;

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();

    newRoomBloc.newRoomStateStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pop(context);
      }
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    startDay = "10/10/2020";
    endDay = DateTime.now().toIso8601String();
    newRoomBloc = new NewRoomBloc()..init();
    controllerName = new TextEditingController();
    controllerDiscountPercent = new TextEditingController();
    controllerPrice = new TextEditingController();
    controllerCity = new TextEditingController();
    controllerDesc = new TextEditingController();
    controllerAddress = new TextEditingController();
    controllerFreeTime = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newRoomBloc.dispose();
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
          "New Room".toUpperCase(),
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
                        stream: newRoomBloc.fileImageStream,
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
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(.7),
                                        width: 2)),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      showGetImage(context);
                                    },
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey.withOpacity(.7),
                                      size: 100,
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
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      hintText: "Name",
                      controller: controllerName,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        color: AppColors.buttonColor,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      maxLine: 4,
                      controller: controllerDesc,
                      hintText: "Description",
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: Icon(
                        Icons.note,
                        color: AppColors.buttonColor,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      "Address",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    XTextFormField(
                      hintText: "Address",
                      controller: controllerAddress,
                      prefixIcon: Icon(
                        Icons.comment_bank,
                        color: AppColors.buttonColor,
                      ),
                      funcValidation: ValidateData.validEmpty,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      "City",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    StreamBuilder<List<Province>>(
                        stream: newRoomBloc.listProvinceStream,
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData) {
                            List<ItemModel> items = [];
                            snapshot1.data.forEach((element) {
                              items.add(new ItemModel(
                                  id: element.code, name: element.name));
                            });
                            return TextFieldChoose(
                              iconData: Icons.location_on,
                              callBack: (val) {
                                controllerCity.text = val;
                              },
                              hintText: "City",
                              items: items,
                            );
                          } else
                            return SizedBox();
                        }),

                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              XTextFormField(
                                controller: controllerPrice,
                                hintText: "0",
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: Icon(
                                  Icons.money,
                                  color: AppColors.buttonColor,
                                ),
                                suffixIcon: Container(
                                  width: 20,
                                  child: Center(
                                      child: Text(
                                        "đ",
                                        style: TextStyle(
                                            color: AppColors.buttonColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      )),
                                ),
                                textInputType: TextInputType.phone,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: 10,
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Discount",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              XTextFormField(
                                controller: controllerDiscountPercent,
                                hintText: "0",
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: Container(
                                  width: 20,
                                  child: Center(
                                      child: Text(
                                        "%",
                                        style: TextStyle(
                                            color: AppColors.buttonColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      )),
                                ),
                                textInputType: TextInputType.phone,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: TextFieldChoose(
                            iconData: Icons.person,
                            callBack: (val) {
                              adults = int.parse(val);
                            },
                            hintText: "Adults",
                            items: [
                              ItemModel(id: '0', name: "0"),
                              ItemModel(id: '1', name: "1"),
                              ItemModel(id: '2', name: "2"),
                              ItemModel(id: '3', name: "3"),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: 10,
                        ),

                        Expanded(
                          child: TextFieldChoose(
                            iconData: Icons.person,
                            callBack: (val) {
                              child = int.parse(val);
                            },
                            hintText: "Child",
                            items: [
                              ItemModel(id: '0', name: "0"),
                              ItemModel(id: '1', name: "1"),
                              ItemModel(id: '2', name: "2"),
                              ItemModel(id: '3', name: "3"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      "Free time",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    GestureDetector(
                      onTap: () async {
                        final List<DateTime> picked =
                        await DateRagePicker.showDatePicker(
                            context: context,
                            initialFirstDate: new DateTime.now(),
                            initialLastDate: (new DateTime.now())
                                .add(new Duration(days: 7)),
                            firstDate: new DateTime(2015),
                            lastDate: new DateTime(2022));
                        if (picked != null && picked.length == 2) {
                          startDay = picked[0].toIso8601String();
                          endDay = picked[1].toIso8601String();
                          controllerFreeTime.text =
                          "${picked[0].day}/${picked[0].month}-${picked[1].day}/${picked[1].month}/${picked[0].year}";
                        }
                      },

                      child: XTextFormField(
                        hintText: "Time",
                        enable: false,
                        controller: controllerFreeTime,
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: AppColors.buttonColor,
                        ),
                        funcValidation: ValidateData.validEmpty,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          StreamBuilder<UIState>(
              stream: newRoomBloc.newRoomStateStream,
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
            try {
              newRoomBloc.addRoom(
                  file,
                  controllerName.text,
                  startDay,
                  endDay,
                  adults,
                  child,
                  controllerAddress.text,
                  controllerCity.text ?? "",
                  controllerDesc.text ?? "",
                  double.parse(controllerPrice.text ?? 0),
                  double.parse(controllerDiscountPercent.text ?? 0));
            } catch (e) {
              FlutterToast().showToast(e.message);
            }
          }
        }),
      ),
    );
  }

  ///
  void showGetImage(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true, ///
        context: context, ///
        backgroundColor: Colors.transparent, ///
        builder: (context) {
          return Container(
            height: 100, ///Container height
            width: double.infinity, ///Container width
            decoration: BoxDecoration(
              color: themeData.scaffoldBackgroundColor, ///Color box
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), ///padding
              child: Row(
                children: [
                  Expanded(
                      child: XButton(
                          "Camera",
                              () {
                        newRoomBloc.getImageByCamera(picker); ///
                      })
                  ),

                  SizedBox(
                    width: 10,
                  ),

                  Expanded(
                      child: XButton("Library", () {
                        newRoomBloc.getImageByGallery(picker); ///
                      })),
                ],
              ),
            ),
          );
        });
  }
}
