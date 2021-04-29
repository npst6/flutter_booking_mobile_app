///Note file item_history.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/model/transaction.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
import 'package:flutter_booking_mobile_app/app/history_booking/bloc/history_booking_bloc.dart';

/// ItemHistory StatefulWidget
class ItemHistory extends StatefulWidget {
  ///historyBookingBloc
  final HistoryBookingBloc historyBookingBloc;

  ///themeData
  final ThemeData themeData;

  ///isCancel
  final bool isCancel;

  ///transactions
  final Transactions transactions;

  ItemHistory(this.themeData, this.transactions, this.historyBookingBloc,
      {this.isCancel = false});
  @override
  _ItemHistoryState createState() => _ItemHistoryState();
}

/// _ItemHistoryState State<>
class _ItemHistoryState extends State<ItemHistory> {
  @override
  void initState() {
    widget.historyBookingBloc.getRoom(widget.transactions.idRoom);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      ///Container height
      height: 150,

      ///Container margin
      margin: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        ///Color box
        color: widget.themeData.scaffoldBackgroundColor,

        ///Border box
        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            ///color
            color: Colors.grey.withOpacity(0.5),

            ///spreadRadius
            spreadRadius: 3,

            ///blurRadius
            blurRadius: 5,

            ///offset
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            ///Flex
            flex: 1,

            child: StreamBuilder<Room>(
              stream: widget.historyBookingBloc.myRoomStream,
              builder: (context, snapshot) {
                return Container(
                  decoration: BoxDecoration(
                    ///Border box
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),

                    ///Image
                    image: snapshot.hasData
                        ? DecorationImage(
                            ///Image
                            image: NetworkImage(snapshot.data.urlImage),

                            ///Image fit
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            ///Image
                            image: AssetImage('assets/images/travel.png'),

                            ///Image fit
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            ///Flex
            flex: 4,

            child: Padding(
              ///Padding
              padding: const EdgeInsets.all(10),

              child: Column(
                ///Using mainAxisAlignment in a Column will align its children vertically.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Expanded(
                        ///Flex
                        flex: 5,

                        child: StreamBuilder<Room>(
                          stream: widget.historyBookingBloc.myRoomStream,
                          builder: (context, snapshot) {
                            return Text(
                              ///Text
                              snapshot.hasData
                                  ? snapshot.data.nameRoom.toUpperCase()
                                  : "",

                              ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                              maxLines: 1,

                              style: TextStyle(
                                ///Text weight
                                fontWeight: FontWeight.w800,

                                ///Text size
                                fontSize: 17,

                                ///Text spacing
                                letterSpacing: 1.6,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    ///Text
                    "x${widget.transactions.numberRoom} Rooms  x${widget.transactions.night} Nights",

                    ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                    maxLines: 1,

                    ///Text align
                    textAlign: TextAlign.start,

                    style: TextStyle(
                      ///Text weight
                      fontWeight: FontWeight.w600,

                      ///Text size
                      fontSize: 15,

                      ///Text font style
                      fontStyle: FontStyle.italic,

                      ///Text color
                      color: Colors.grey,

                      ///Text spacing
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          ///Text
                          widget.transactions.checkIn,

                          ///Text Align
                          textAlign: TextAlign.start,

                          ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                          maxLines: 1,

                          style: TextStyle(
                            ///Text weight
                            fontWeight: FontWeight.w600,

                            ///Text spacing
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Icon(
                        ///Icon
                        Icons.arrow_forward,

                        ///Icon size
                        size: 15,

                        ///Icon color
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        ///Flex
                        flex: 2,

                        ///Text
                        child: Text(
                          ///Text
                          widget.transactions.checkOut,

                          ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                          maxLines: 1,

                          ///Text align
                          textAlign: TextAlign.start,

                          style: TextStyle(
                            ///Text weight
                            fontWeight: FontWeight.w600,

                            ///Text spacing
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        ///Flex
                        flex: 2,

                        child: Text(
                          ///Text
                          "${widget.transactions.totalMoney.toInt()}\$",

                          ///Text align
                          textAlign: TextAlign.start,

                          ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                          maxLines: 1,

                          style: TextStyle(
                            ///Text color
                            color: AppColors.primaryColor,

                            ///Text weight
                            fontWeight: FontWeight.w900,

                            ///Text size
                            fontSize: 23,

                            ///Text spacing
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        ///Flex
                        flex: 1,

                        child: widget.isCancel
                            ? XButton(
                                "Cancel",
                                () {
                                  FirAuth().updateOrderStatus(
                                    3,
                                    widget.transactions.id,
                                    () {
                                      widget.historyBookingBloc
                                          .getHistoryBooking();
                                    },
                                  );
                                },
                                color: Colors.grey,
                                height: 30,
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    ///Text
                    "Create: ${DateTime.parse(widget.transactions.createDay).day}/${DateTime.parse(widget.transactions.createDay).month}/${DateTime.parse(widget.transactions.createDay).year}",

                    style: TextStyle(
                      ///Text font style
                      fontStyle: FontStyle.italic,
                    ),

                    ///Text align
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
