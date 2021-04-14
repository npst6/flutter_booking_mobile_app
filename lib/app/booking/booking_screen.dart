///Note file booking_screen.dart

import 'widget/item_details_tax.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/pop_up_bank_transfer.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/utils/order_utils.dart';
import 'package:flutter_booking_mobile_app/model/my_home_stay.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
import 'package:flutter_booking_mobile_app/app/history_booking/history_booking_screen.dart';

///BookingScreen StatefulWidget
class BookingScreen extends StatefulWidget {
  ///Declare the variables to be passed to the screen
  final Room room;
  final MyHomeStay myHomeStay;
  const BookingScreen({Key key, this.room, this.myHomeStay}) : super(key: key);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

/// _BookingScreenState State<>
class _BookingScreenState extends State<BookingScreen> {
  ///Initialization
  ThemeData themeData;
  TextEditingController controllerCheckIn;
  TextEditingController controllerCheckOut;
  TextEditingController controllerNight;
  TextEditingController controllerNumberRoom;
  TextEditingController controllerType;

  @override
  void initState() {
    controllerCheckIn = new TextEditingController(
        text:
            "${DateTime.parse(OrderUtils().startDay).day}/${DateTime.parse(OrderUtils().startDay).month}/${DateTime.parse(OrderUtils().startDay).year}");
    controllerCheckOut = new TextEditingController(
        text:
            "${DateTime.parse(OrderUtils().endDay).day}/${DateTime.parse(OrderUtils().endDay).month}/${DateTime.parse(OrderUtils().endDay).year}");
    controllerNight = new TextEditingController(
        text:
            "${DateTime.parse(OrderUtils().endDay).difference(DateTime.parse(OrderUtils().startDay)).inDays}");
    controllerNumberRoom =
        new TextEditingController(text: "${OrderUtils().numberRoom}");
    controllerType = new TextEditingController(
        text:
            "${widget.room.numberAdults} Adults - ${widget.room.numberChild} Child");
    super.initState();
  }

  ///Listen for changes
  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    super.didChangeDependencies();
  }

  ///Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///Background color
        backgroundColor: themeData.scaffoldBackgroundColor,

        ///Elevation
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            ///Padding
            padding: const EdgeInsets.all(15),
            child: Container(
              ///Container height
              height: 30,

              ///Container width
              width: 30,
              decoration: BoxDecoration(
                ///Color box
                color: AppColors.buttonColor,

                ///Border box
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  ///Icon
                  Icons.arrow_back_ios_rounded,

                  ///Icon color
                  color: themeData.scaffoldBackgroundColor,

                  ///Icon size
                  size: 15,
                ),
              ),
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
          widget.myHomeStay.name.toUpperCase(),
          style: TextStyle(
            ///Text size
            fontSize: 20,

            ///Text weight
            fontWeight: FontWeight.bold,

            ///Text color
            color: Colors.black,
          ),
        ),
      ),

      ///Body
      body: Padding(
        ///Padding
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: SingleChildScrollView(
          child: Column(
            ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                ///Container height
                height: 100,

                ///Container width
                width: double.infinity,
                child: Row(
                  ///Using crossAxisAlignment in the Row allows you to determine how its children are aligned vertically.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          ///Border box
                          borderRadius: BorderRadius.circular(20),

                          ///Image
                          image: DecorationImage(
                            ///Image
                            image: NetworkImage(widget.room.urlImage),

                            ///Image fit
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        ///Padding
                        padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                        child: Column(
                          ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ///Text
                              widget.room.nameRoom,
                              style: TextStyle(
                                ///Text weight
                                fontWeight: FontWeight.w800,

                                ///Text size
                                fontSize: 16,

                                ///Text spacing
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  ///Icon
                                  Icons.star,

                                  ///Icon color
                                  color: Colors.yellow,
                                ),
                                Text(
                                  ///Text
                                  "4.5",
                                  style: TextStyle(
                                    ///Text weight
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ///Text
                          "Check-in",
                          style: TextStyle(
                            ///Text color
                            color: Colors.grey,

                            ///Text weight
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        XTextFormField(
                          controller: controllerCheckIn,
                          prefixIcon: Icon(
                            ///Icon
                            Icons.calendar_today,

                            ///Icon color
                            color: AppColors.buttonColor,
                          ),
                          enable: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ///Text
                          "Check-out",
                          style: TextStyle(
                            ///Text color
                            color: Colors.grey,

                            ///Text weight
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        XTextFormField(
                          controller: controllerCheckOut,
                          enable: false,
                          prefixIcon: Icon(
                            ///Icon
                            Icons.calendar_today,

                            ///Icon color
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
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
                          ///Text
                          "Night",
                          style: TextStyle(
                            ///Text color
                            color: Colors.grey,

                            ///Text weight
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        XTextFormField(
                          controller: controllerNight,
                          enable: false,
                          prefixIcon: Icon(
                            ///Icon
                            Icons.nights_stay_outlined,

                            ///Icon color
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ///Text
                          "Number room",
                          style: TextStyle(
                            ///Text color
                            color: Colors.grey,

                            ///Text weight
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        XTextFormField(
                          controller: controllerNumberRoom,
                          enable: false,
                          prefixIcon: Icon(
                            ///Text icon
                            Icons.night_shelter_outlined,

                            ///Text color
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                ///Text
                "Type room",
                style: TextStyle(
                  ///Text color
                  color: Colors.grey,

                  ///Text weight
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              XTextFormField(
                controller: controllerType,
                enable: false,

                ///Hint text
                hintText: "One adult, two children",
                prefixIcon: Icon(
                  ///Icon
                  Icons.person_outline,

                  ///Icon color
                  color: AppColors.buttonColor,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.grey,
                height: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ///Text
                "Fee and tax details:",
                style: TextStyle(
                  ///Text weight
                  fontWeight: FontWeight.w700,

                  ///Text spacing
                  letterSpacing: 1,
                ),
              ),
              Padding(
                ///Padding
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemDetailsTax(
                      title: "Per night",
                      isShowNumber: true,
                      number: OrderUtils().numberRoom,
                      price: (widget.room.money -
                          widget.room.money * widget.room.discount / 100),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                ///Padding
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ///Text
                      "Total",
                      style: TextStyle(
                        ///Text weight
                        fontWeight: FontWeight.w700,

                        ///Text color
                        color: AppColors.buttonColor,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text size
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      ///Text
                      "${(widget.room.money - widget.room.money * widget.room.discount / 100) * OrderUtils().numberRoom * int.parse(controllerNight.text)}\$",
                      style: TextStyle(
                        ///Text weight
                        fontWeight: FontWeight.w700,

                        ///Text spacing
                        letterSpacing: 1,

                        ///Text color
                        color: AppColors.buttonColor,

                        ///Text size
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        ///Padding
        padding: const EdgeInsets.all(15),

        ///Book now button
        child: XButton("Book now", () {
          showBankTransfer(themeData);
        }),
      ),
    );
  }

  void showBankTransfer(ThemeData themeData) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Center(
            child: PopUpBankTransfer(
                themeData,
                widget.myHomeStay,
                (widget.room.money -
                        widget.room.money * widget.room.discount / 100) *
                    OrderUtils().numberRoom *
                    int.parse(controllerNight.text), () {
          FirAuth().createOrder(
              widget.room.idRoom,
              controllerCheckIn.text,
              controllerCheckOut.text,
              int.parse(controllerNight.text),
              int.parse(controllerNumberRoom.text),
              (widget.room.money -
                      widget.room.money * widget.room.discount / 100) *
                  OrderUtils().numberRoom *
                  int.parse(controllerNight.text), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return HistoryBookingScreen();
            }));
          }, (val) {});
        }));
      },
      isScrollControlled: true,
    );
  }
}
