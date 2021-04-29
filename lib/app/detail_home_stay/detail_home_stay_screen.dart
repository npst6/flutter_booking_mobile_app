///Note file detail_home_stay_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/theme/theme.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/model/my_home_stay.dart';
import 'package:flutter_booking_mobile_app/app/booking/booking_screen.dart';
import 'package:flutter_booking_mobile_app/app/detail_home_stay/bloc/detail_home_stay_bloc.dart';

///DetailHomeStayScreen StatefulWidget
class DetailHomeStayScreen extends StatefulWidget {
  final Room room;
  DetailHomeStayScreen(this.room);
  @override
  _DetailHomeStayScreenState createState() => _DetailHomeStayScreenState();
}

/// _DetailHomeStayScreenState State<>
class _DetailHomeStayScreenState extends State<DetailHomeStayScreen> {
  ThemeData themeData;
  DetailBloc detailBloc;
  @override
  void initState() {
    detailBloc = new DetailBloc()..getMyHomeStay(widget.room.idHotel);
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
          StreamBuilder<MyHomeStay>(
              stream: detailBloc.myHomeStayStream,
              builder: (context, snapshot1) {
                return Column(
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
                      decoration: BoxDecoration(
                        ///Border box
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
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
                              ///Text
                              snapshot1.data != null
                                  ? snapshot1.data.name.toUpperCase()
                                  : "".toUpperCase(),
                              style: TextStyle(
                                ///Text weight
                                fontWeight: FontWeight.w900,

                                ///Text size
                                fontSize: 20,

                                ///Text spacing
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(
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
                                SizedBox(width: 10),
                                Text(
                                  ///Text
                                  "${widget.room.address}, ${widget.room.city}",

                                  ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                                  maxLines: 2,
                                  style: TextStyle(
                                    ///Text spacing
                                    letterSpacing: .6,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              ///Using crossAxisAlignment in the Row allows you to determine how its children are aligned vertically.
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  ///Flex
                                  flex: 3,
                                  child: Text(
                                    ///Text
                                    "${snapshot1.data != null ? snapshot1.data.listReviews.length : 0} reviews",

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
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          ///Icon
                                          Icons.star,

                                          ///Icon color
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          ///Text
                                          "5",
                                          style: TextStyle(
                                            ///Text weight
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(
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
                                        ///Text size
                                        fontSize: 16,

                                        ///Text weight
                                        fontWeight: FontWeight.w700,

                                        ///Text spacing
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      ///Text
                                      widget.room.desc,

                                      ///Use the ... sign to indicate overflow of text
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        ///Text weight
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

                            ///Book now button
                            XButton("Book now", () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return BookingScreen(
                                  room: widget.room,
                                  myHomeStay: snapshot1.data,
                                );
                              }));
                            }),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
