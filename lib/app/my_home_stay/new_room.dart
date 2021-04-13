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

///NewRoom StatefulWidget
class NewRoom extends StatefulWidget {
  @override
  _NewRoomState createState() => _NewRoomState();
}

/// _NewRoomState State<>
class _NewRoomState extends State<NewRoom> {
  ThemeData themeData;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerName;
  TextEditingController controllerDesc;
  TextEditingController controllerAddress;
  TextEditingController controllerFreeTime;
  TextEditingController controllerCity;
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
        ///Background color
        backgroundColor: themeData.scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            ///Padding
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
          "New Room".toUpperCase(),
          style: TextStyle(
            ///Text size
            fontSize: 20,

            ///Text color
            color: Colors.black,

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
                key: _formKey,
                child: Column(
                  ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<File>(
                        stream: newRoomBloc.fileImageStream,
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
                                  ///Border box
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(

                                      ///Border color
                                      color: Colors.grey.withOpacity(.7),

                                      ///Border width
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
                      "Description",
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
                      controller: controllerDesc,

                      ///Hint text
                      hintText: "Description",

                      ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                      maxLine: 4,

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: Icon(
                        ///Icon
                        Icons.note,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Address",
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
                      controller: controllerAddress,

                      ///Hint text
                      hintText: "Address",
                      prefixIcon: Icon(
                        ///Icon
                        Icons.comment_bank,

                        ///Icon color
                        color: AppColors.buttonColor,
                      ),

                      ///Check empty data
                      funcValidation: ValidateData.validEmpty,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "City",
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
                              ///Icon
                              iconData: Icons.location_on,
                              callBack: (val) {
                                controllerCity.text = val;
                              },

                              ///Hint text
                              hintText: "City",

                              ///Item
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
                            ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
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
                                controller: controllerPrice,

                                ///Hint text
                                hintText: "0",

                                ///Check empty data
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: Icon(
                                  ///Icon
                                  Icons.money,

                                  ///Icon color
                                  color: AppColors.buttonColor,
                                ),
                                suffixIcon: Container(
                                  width: 20,
                                  child: Center(
                                      child: Text(
                                    "đ",
                                    style: TextStyle(
                                      ///Text color
                                      color: AppColors.buttonColor,

                                      ///Text size
                                      fontSize: 16,

                                      ///Text weight
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )),
                                ),

                                ///Text type phone
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
                            ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Discount",
                                style: TextStyle(
                                  ///Text size
                                  fontSize: 15,

                                  ///Text weight
                                  fontWeight: FontWeight.w500,

                                  ///Text spacing
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              XTextFormField(
                                controller: controllerDiscountPercent,

                                ///Hint text
                                hintText: "0",

                                ///Check empty data
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: Container(
                                  width: 20,
                                  child: Center(
                                      child: Text(
                                    "%",
                                    style: TextStyle(
                                      ///Text color
                                      color: AppColors.buttonColor,

                                      ///Text size
                                      fontSize: 16,

                                      ///Text weight
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )),
                                ),

                                ///Text type phone
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
                            ///Icon
                            iconData: Icons.person,
                            callBack: (val) {
                              adults = int.parse(val);
                            },
                            hintText: "Adults",
                            items: [
                              ItemModel(id: '1', name: "01"),
                              ItemModel(id: '2', name: "02"),
                              ItemModel(id: '3', name: "03"),
                              ItemModel(id: '4', name: "04"),
                              ItemModel(id: '5', name: "05"),
                              ItemModel(id: '6', name: "06"),
                              ItemModel(id: '7', name: "07"),
                              ItemModel(id: '8', name: "08"),
                              ItemModel(id: '9', name: "09"),
                              ItemModel(id: '10', name: "10"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFieldChoose(
                            ///Icon
                            iconData: Icons.person,
                            callBack: (val) {
                              child = int.parse(val);
                            },

                            ///Hint text
                            hintText: "Child",
                            items: [
                              ItemModel(id: '1', name: "01"),
                              ItemModel(id: '2', name: "02"),
                              ItemModel(id: '3', name: "03"),
                              ItemModel(id: '4', name: "04"),
                              ItemModel(id: '5', name: "05"),
                              ItemModel(id: '6', name: "06"),
                              ItemModel(id: '7', name: "07"),
                              ItemModel(id: '8', name: "08"),
                              ItemModel(id: '9', name: "09"),
                              ItemModel(id: '10', name: "10"),
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
                        ///Text size
                        fontSize: 15,

                        ///Text weight
                        fontWeight: FontWeight.w500,

                        ///Text spacing
                        letterSpacing: 1,
                      ),
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
                        controller: controllerFreeTime,
                        enable: false,

                        ///Hint text
                        hintText: "Time",
                        prefixIcon: Icon(
                          ///Icon
                          Icons.calendar_today,

                          ///Icon color
                          color: AppColors.buttonColor,
                        ),

                        ///Check empty data
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
        ///Padding
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),

        ///Save button
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

  void showGetImage(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
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
                  Expanded(

                      ///Button Camera
                      child: XButton("Camera", () {
                    newRoomBloc.getImageByCamera(picker);
                  })),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(

                      ///Button Library
                      child: XButton("Library", () {
                    newRoomBloc.getImageByGallery(picker);
                  })),
                ],
              ),
            ),
          );
        });
  }
}
