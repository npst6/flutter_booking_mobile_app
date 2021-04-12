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
//------------------------------------------------------------------------------
class EditRoomScreen extends StatefulWidget {
  final Room room;
  EditRoomScreen(this.room);
  @override
  _NewRoomState createState() => _NewRoomState();
}

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
          "Edit Room".toUpperCase(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete,
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
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                    image: FileImage(
                                      snapshot.data,
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            );
                          } else
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          widget.room.urlImage,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey,
                                      size: 100,
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
                        stream: editRoomBloc.listProvinceStream,
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData) {
                            List<ItemModel> items = [];
                            snapshot1.data.forEach((element) {
                              items.add(new ItemModel(
                                  id: element.code, name: element.name));
                            });
                            return TextFieldChoose(
                              intiText: controllerCity.text,
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
                            intiText: adults.toString(),
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
                            intiText: child.toString(),
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
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
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
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
                color: themeData.scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: XButton("Camera", () {
                        editRoomBloc.getImageByCamera(picker);
                      })),
                  SizedBox(
                    width: 10,
                  ),
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
