///Note file detail_history_booking.dart

import 'package:intl/intl.dart';
import 'detail_history_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/item_service.dart';
import 'package:flutter_booking_mobile_app/base/x_text_form_field.dart';
import 'package:flutter_booking_mobile_app/app/booking/widget/item_details_tax.dart';

/// DetailsHistoryBookingScreen StatefulWidget
class DetailsHistoryBookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

/// _BookingScreenState State<>
class _BookingScreenState extends State<DetailsHistoryBookingScreen> {
  ThemeData themeData;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    super.didChangeDependencies();
  }

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
                  color: AppColors.primaryColor,

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
          title: Text(
            "Booking hotel".toUpperCase(),
            style: TextStyle(
              ///Text size
              fontSize: 20,

              ///Text weight
              fontWeight: FontWeight.bold,

              ///Text color
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              ///Padding
              padding: const EdgeInsets.all(8.0),
              child: Container(
                ///Container width
                width: 40,

                ///Container height
                height: 40,
                decoration: BoxDecoration(
                  ///Border box
                  borderRadius: BorderRadius.circular(10),

                  ///Image
                  image: DecorationImage(

                      ///Image
                      image: AssetImage('assets/images/travel.png'),

                      ///Image fit
                      fit: BoxFit.cover),
                ),
              ),
            )
          ],
        ),
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
                              image: AssetImage('assets/images/travel.png'),

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
                                "Room 2 person",
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
                              )
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
                Container(
                  height: 65,
                  child: Row(
                    ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                    mainAxisAlignment: MainAxisAlignment.start,

                    ///Using crossAxisAlignment in the Row allows you to determine how its children are aligned vertically.
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemService(
                        Icon(
                          ///Icon
                          Icons.wifi,

                          ///Icon color
                          color: AppColors.primaryColor,
                        ),
                        "Wifi",
                      ),
                      ItemService(
                        Icon(
                          ///Icon
                          Icons.camera_rear,

                          ///Icon color
                          color: AppColors.primaryColor,
                        ),
                        "Camera",
                      ),
                      ItemService(
                        Icon(
                          ///Icon
                          Icons.gps_fixed,

                          ///Icon color
                          color: AppColors.primaryColor,
                        ),
                        "Gps",
                      ),
                      ItemService(
                        Icon(
                          ///Icon
                          Icons.access_alarms,

                          ///Icon color
                          color: AppColors.primaryColor,
                        ),
                        "Alarms",
                      ),
                      ItemService(
                        Icon(
                          ///Icon
                          Icons.airline_seat_recline_extra,

                          ///Icon color
                          color: AppColors.primaryColor,
                        ),
                        "Seat",
                      ),
                    ],
                  ),
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
                            prefixIcon: Icon(
                              ///Icon
                              Icons.calendar_today,

                              ///Icon color
                              color: AppColors.primaryColor,
                            ),

                            ///Hint text
                            hintText: "30/11/2020",
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
                            prefixIcon: Icon(
                              ///Icon
                              Icons.calendar_today,

                              ///Icon color
                              color: AppColors.primaryColor,
                            ),

                            ///Hint text
                            hintText: "01/11/2020",
                            enable: false,
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
                            prefixIcon: Icon(
                              ///Icon
                              Icons.nights_stay_outlined,

                              ///Icon color
                              color: AppColors.primaryColor,
                            ),

                            ///Hint text
                            hintText: "1 Night",
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
                            prefixIcon: Icon(
                              ///Icon
                              Icons.night_shelter_outlined,

                              ///Icon color
                              color: AppColors.primaryColor,
                            ),

                            ///Hint text
                            hintText: "2",
                            suffixIcon: Icon(
                              ///Icon
                              Icons.arrow_drop_down,

                              ///Icon color
                              color: Colors.grey,
                            ),
                            enable: false,
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
                  prefixIcon: Icon(
                    ///Icon
                    Icons.person_outline,

                    ///Icon color
                    color: AppColors.primaryColor,
                  ),

                  ///Hint text
                  hintText: "One adult, Two children",
                  enable: false,
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
                        number: 1,
                        price: 230.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ItemDetailsTax(
                        title: "Car",
                        isShowNumber: true,
                        number: 2,
                        price: 230.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ItemDetailsTax(
                        title: "Discount",
                        number: 1,
                        price: -22.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ItemDetailsTax(
                        title: "Per night",
                        number: 1,
                        price: 0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ItemDetailsTax(
                        title: "Per night",
                        number: 1,
                        price: 0,
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
                    ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ///Text
                        "Total",
                        style: TextStyle(
                          ///Text weight
                          fontWeight: FontWeight.w700,

                          ///Text color
                          color: AppColors.primaryColor,

                          ///Text spacing
                          letterSpacing: 1,

                          ///Text size
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        ///Text
                        "360\$",
                        style: TextStyle(
                          ///Text weight
                          fontWeight: FontWeight.w700,

                          ///Text spacing
                          letterSpacing: 1,

                          ///Text color
                          color: AppColors.primaryColor,

                          ///Text size
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    ///Text
                    "-- " +
                        DateFormat.yMMMMd('en').format(DateTime.now()) +
                        " --",
                    style: TextStyle(
                      ///Text size
                      fontSize: 15,

                      ///Text weight
                      fontWeight: FontWeight.w600,

                      ///Text font style
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailsRoomHistoryScreen();
            }));
          },
          child: Container(
            ///Container height
            height: 50,

            ///Container width
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  ///Color border
                  color: Colors.grey,

                  ///Width border
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: Text(
                ///Text
                "See room details",
                style: TextStyle(
                  ///Text size
                  fontSize: 16,

                  ///Text weight
                  fontWeight: FontWeight.w500,

                  ///Text color
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ));
  }
}
