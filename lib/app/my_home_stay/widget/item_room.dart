///Note
import '../edit_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/app/my_home_stay/bloc/my_home_stay_bloc.dart';
//--
// import 'package:bookingapp/app/history_booking/child_screen/details_history_booking.dart';
//------------------------------------------------------------------------------
/// class ItemMyRoom extends StatelessWidget
class ItemMyRoom extends StatelessWidget {
  final ThemeData themeData;
  final Room room;
  final HomeStayBloc homeStayBloc;
  ItemMyRoom(this.themeData, this.room, this.homeStayBloc);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(room.urlImage), fit: BoxFit.cover)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          room.nameRoom.toUpperCase(),
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              letterSpacing: 1.6),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return EditRoomScreen(room);
                                  }));
                              homeStayBloc.getMyRoom();
                            },
                            child: Icon(
                              Icons.error,
                              color: AppColors.buttonColor,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${room.numberChild} children - ${room.numberAdults} adults",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "x${room.numberRoom} Room",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${DateTime.parse(room.startDay).day}/${DateTime.parse(room.startDay).month}/${DateTime.parse(room.startDay).year}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, letterSpacing: 1),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.grey,
                        size: 15,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${DateTime.parse(room.endDay).day}/${DateTime.parse(room.endDay).month}/${DateTime.parse(room.endDay).year}",
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      room.discount != 0
                          ? Text(
                        "${room.money.toInt()}\đ",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            letterSpacing: 1),
                      )
                          : SizedBox(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${(room.money - room.money * room.discount / 100).toInt()}\đ",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 23,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
