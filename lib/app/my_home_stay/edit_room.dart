///Note file edit_room.dart

import 'dart:io';
import 'bloc/edit_room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/loading_bar.dart';
import 'package:flutter_booking_mobile_app/model/item_model.dart';
import 'package:flutter_booking_mobile_app/utils/validate_data.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/base/text_field_choose.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter_booking_mobile_app/remote/province_response/province_response.dart';

///EditRoomScreen StatefulWidget
class EditRoomScreen extends StatefulWidget {
  final Room room;
  EditRoomScreen(this.room);
  @override
  _NewRoomState createState() => _NewRoomState();
}

/// _NewRoomState State<>
class _NewRoomState extends State<EditRoomScreen> {
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
  EditRoomBloc editRoomBloc;
  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    editRoomBloc.editRoomStateStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pop(context);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    child = widget.room.numberChild;
    adults = widget.room.numberAdults;
    startDay = widget.room.startDay;
    endDay = widget.room.endDay;
    editRoomBloc = new EditRoomBloc()..init();
    controllerName = new TextEditingController(text: widget.room.nameRoom);
    controllerDiscountPercent =
        new TextEditingController(text: widget.room.discount.toString());
    controllerPrice =
        new TextEditingController(text: widget.room.money.toString());
    controllerCity = new TextEditingController(text: widget.room.city);
    controllerDesc = new TextEditingController(text: widget.room.desc);
    controllerAddress = new TextEditingController(text: widget.room.address);
    controllerFreeTime = new TextEditingController(
        text:
            "${DateTime.parse(widget.room.startDay).day}/${DateTime.parse(widget.room.startDay).month} - ${DateTime.parse(widget.room.endDay).day}/${DateTime.parse(widget.room.endDay).month}/${DateTime.parse(widget.room.endDay).year}");

    super.initState();
  }

  @override
  void dispose() {
    editRoomBloc.dispose();
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
          "Edit Room".toUpperCase(),
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
                editRoomBloc.deleteRoomById(widget.room.idRoom);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<File>(
                        stream: editRoomBloc.fileImageStream,
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
                            return Stack(
                              ///Alignment
                              alignment: Alignment.center,
                              children: [
                                Container(
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
                                        widget.room.urlImage,
                                      ),

                                      ///Image fit
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      ///Icon
                                      Icons.camera_alt,

                                      ///Icon size
                                      size: 100,

                                      ///Icon color
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      showGetImage(context);
                                    })
                              ],
                            );
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

                      ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                      maxLine: 4,

                      ///Hint text
                      hintText: "Description",

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
                        stream: editRoomBloc.listProvinceStream,
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData) {
                            List<ItemModel> items = [];
                            snapshot1.data.forEach((element) {
                              items.add(new ItemModel(
                                  id: element.code, name: element.name));
                            });
                            return TextFieldChoose(
                              ///Item
                              items: items,

                              ///Hint text
                              hintText: "City",

                              ///Icon
                              iconData: Icons.location_on,
                              intiText: controllerCity.text,
                              callBack: (val) {
                                controllerCity.text = val;
                              },
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

                                ///Text type phone
                                textInputType: TextInputType.phone,

                                ///Check empty data
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: Icon(
                                  ///Icon
                                  Icons.money,

                                  ///Icon color
                                  color: AppColors.buttonColor,
                                ),
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
                                controller: controllerDiscountPercent,

                                ///Hint text
                                hintText: "0",

                                ///Text type phone
                                textInputType: TextInputType.phone,

                                ///Check empty data
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: Container(
                                  width: 20,
                                  child: Center(
                                    child: Text(
                                      "%",
                                      style: TextStyle(
                                        ///Text size
                                        fontSize: 16,

                                        ///Text color
                                        color: AppColors.buttonColor,

                                        ///Text weight
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
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
                            ///Hint text
                            hintText: "Adults",

                            ///Icon
                            iconData: Icons.person,
                            intiText: adults.toString(),
                            callBack: (val) {
                              adults = int.parse(val);
                            },
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
                            ///Hint text
                            hintText: "Child",

                            ///Icon
                            iconData: Icons.person,
                            intiText: child.toString(),
                            callBack: (val) {
                              child = int.parse(val);
                            },
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

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text weight
                        fontWeight: FontWeight.w500,
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

                        ///Check empty data
                        funcValidation: ValidateData.validEmpty,
                        prefixIcon: Icon(
                          ///Icon
                          Icons.calendar_today,

                          ///Icon color
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
              stream: editRoomBloc.editRoomStateStream,
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
              if (file == null) {
                editRoomBloc.updateRoomNotFile(
                    widget.room.urlImage,
                    widget.room.idRoom,
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
              } else {
                editRoomBloc.updateRoomHaveFile(
                    file,
                    widget.room.idRoom,
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
              }
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
              ///Color box
              color: themeData.scaffoldBackgroundColor,

              ///Border box
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Padding(
              ///Padding
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  ///Camera button
                  Expanded(
                      child: XButton("Camera", () {
                    editRoomBloc.getImageByCamera(picker);
                  })),
                  SizedBox(
                    width: 10,
                  ),

                  ///Library button
                  Expanded(
                      child: XButton("Library", () {
                    editRoomBloc.getImageByGallery(picker);
                  })),
                ],
              ),
            ),
          );
        });
  }
}
