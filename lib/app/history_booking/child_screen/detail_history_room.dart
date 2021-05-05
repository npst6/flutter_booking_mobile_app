///Note file detail_history_room.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/item_service.dart';

///DetailsRoomHistoryScreen StatefulWidget
class DetailsRoomHistoryScreen extends StatefulWidget {
  ///room
  final Room room;

  DetailsRoomHistoryScreen({this.room});

  @override
  _DetailHomeStayScreenState createState() => _DetailHomeStayScreenState();
}

///_DetailHomeStayScreenState State<>
class _DetailHomeStayScreenState extends State<DetailsRoomHistoryScreen> {
  ///themeData
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ///themeData
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            ///Container height
            height: MediaQuery.of(context).size.height,

            ///Container width
            width: double.infinity,

            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      ///Container height
                      height: MediaQuery.of(context).size.height * 0.6,

                      decoration: BoxDecoration(
                        ///Image
                        image: DecorationImage(
                          ///Image
                          image: NetworkImage(widget.room.urlImage),

                          ///Image fit
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      ///Padding
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),

                      child: Row(
                        ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          GestureDetector(
                            ///onTap
                            onTap: () {
                              Navigator.pop(context);
                            },

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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            ///Using mainAxisAlignment in a Column will align its children vertically.
            mainAxisAlignment: MainAxisAlignment.end,

            ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                ///Alignment
                alignment: Alignment.bottomCenter,

                ///Container height
                height: MediaQuery.of(context).size.height * 0.5,

                ///Decoration
                decoration: BoxDecoration(
                  ///Border box
                  borderRadius: BorderRadius.only(
                    ///topRight
                    topRight: Radius.circular(30),

                    ///topLeft
                    topLeft: Radius.circular(30),
                  ),

                  ///Color box
                  color: themeData.scaffoldBackgroundColor,
                ),

                child: Padding(
                  ///Padding
                  padding: const EdgeInsets.fromLTRB(30, 25, 30, 5),

                  child: Column(
                    ///Using mainAxisAlignment in a Column will align its children vertically.
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        ///Test
                        "Booking Hotels".toUpperCase(),

                        style: TextStyle(
                          ///Text weight
                          fontWeight: FontWeight.w900,

                          ///Text size
                          fontSize: 20,

                          ///Text spacing
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            ///Icon
                            Icons.location_on,

                            ///Icon color
                            color: AppColors.primaryColor,

                            ///Icon size
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            ///Text
                            "${widget.room.address}, ${widget.room.city} ",

                            ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                            maxLines: 2,

                            style: TextStyle(
                              ///Text spacing
                              letterSpacing: .6,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        ///Using crossAxisAlignment in the Row allows you to determine how its children are aligned vertically.
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Expanded(
                            ///Flex
                            flex: 2,

                            child: Row(
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
                          ),
                          Expanded(
                            ///Flex
                            flex: 3,

                            child: Text(
                              ///Text
                              "420 Reviews",

                              ///Text align
                              textAlign: TextAlign.start,

                              style: TextStyle(
                                ///Text color
                                color: Colors.grey,

                                ///Text weight
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        ///Container height
                        height: 65,

                        decoration: BoxDecoration(
                          ///Color box
                          color: AppColors.grey.withOpacity(.3),

                          ///Border box
                          borderRadius: BorderRadius.circular(25),
                        ),

                        child: Row(
                          ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                          mainAxisAlignment: MainAxisAlignment.center,

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
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                ///Text
                                widget.room.nameRoom,

                                ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                                maxLines: 1,

                                style: TextStyle(
                                  ///Text weight
                                  fontWeight: FontWeight.w700,

                                  ///Text size
                                  fontSize: 16,

                                  ///Text spacing
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                ///Text
                                widget.room.desc,

                                ///overflow
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  ///Text spacing
                                  letterSpacing: 1,
                                ),

                                maxLines: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.47,
            right: 25,
            child: Container(
              ///Container width
              width: 50,

              ///Container height
              height: 50,

              ///decoration
              decoration: BoxDecoration(
                ///boxShadow
                boxShadow: [
                  BoxShadow(
                    ///color
                    color: Colors.grey.withOpacity(0.2),

                    ///spreadRadius
                    spreadRadius: 6,

                    ///blurRadius
                    blurRadius: 5,

                    ///offset
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],

                ///Shape box
                shape: BoxShape.circle,

                ///Color box
                color: themeData.scaffoldBackgroundColor,
              ),

              child: Icon(
                ///Icon
                Icons.favorite,

                ///Icon color
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
