///Note file item_room.dart

import '../edit_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/app/my_home_stay/bloc/my_home_stay_bloc.dart';

///ItemMyRoom StatelessWidget
class ItemMyRoom extends StatelessWidget {
  ///themeData
  final ThemeData themeData;

  ///room
  final Room room;

  ///homeStayBloc
  final HomeStayBloc homeStayBloc;

  ItemMyRoom(
    this.themeData,
    this.room,
    this.homeStayBloc,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      ///Container height
      height: 150,

      ///Container margin
      margin: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        ///Color box
        color: themeData.scaffoldBackgroundColor,

        ///Border box
        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            ///color
            color: Colors.grey.withOpacity(0.5),

            ///offset
            offset: Offset(0, 3),

            ///blurRadius
            blurRadius: 5,

            ///spreadRadius
            spreadRadius: 3, // changes position of shadow
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            ///Flex
            flex: 1,

            child: Container(
              decoration: BoxDecoration(
                ///Border box
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),

                ///Image
                image: DecorationImage(

                    ///Imagge
                    image: NetworkImage(room.urlImage),

                    ///Image fit
                    fit: BoxFit.cover),
              ),
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

                        child: Text(
                          ///Text
                          room.nameRoom.toUpperCase(),

                          ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                          maxLines: 1,

                          style: TextStyle(
                            ///Text size
                            fontSize: 15,

                            ///Text weight
                            fontWeight: FontWeight.w800,

                            ///Text spacing
                            letterSpacing: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditRoomScreen(room);
                                },
                              ),
                            );
                            homeStayBloc.getMyRoom();
                          },
                          child: Icon(
                            ///Icon
                            Icons.error,

                            ///Icon color
                            color: AppColors.buttonColor,
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
                          "${room.numberChild} children - ${room.numberAdults} adults",

                          ///Text align
                          textAlign: TextAlign.start,

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
                      ),
                      Expanded(
                        child: Text(
                          ///Text
                          "x${room.numberRoom} Room",

                          ///Text align
                          textAlign: TextAlign.center,

                          ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                          maxLines: 1,

                          style: TextStyle(
                            ///Text color
                            color: Colors.grey,

                            ///Text weight
                            fontWeight: FontWeight.w600,

                            ///Text style
                            fontStyle: FontStyle.italic,

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
                        child: Text(
                          ///Text
                          "${DateTime.parse(room.startDay).day}/${DateTime.parse(room.startDay).month}/${DateTime.parse(room.startDay).year}",

                          ///Text align
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
                        ///icon
                        Icons.arrow_forward,

                        ///Icon size
                        size: 15,

                        ///Icon color
                        color: Colors.grey,
                      ),
                      Expanded(
                        ///Flex
                        flex: 2,

                        child: Text(
                          ///Text
                          "${DateTime.parse(room.endDay).day}/${DateTime.parse(room.endDay).month}/${DateTime.parse(room.endDay).year}",

                          ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                          maxLines: 1,

                          ///Text align
                          textAlign: TextAlign.start,

                          style: TextStyle(
                            ///Text spacing
                            letterSpacing: 1,

                            ///Text weight
                            fontWeight: FontWeight.w600,
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
                      room.discount != 0
                          ? Text(
                              ///Text
                              "${room.money.toInt()}\đ",

                              ///Text align
                              textAlign: TextAlign.start,

                              ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                              maxLines: 1,
                              style: TextStyle(
                                ///Text color
                                color: AppColors.buttonColor,

                                ///Text size
                                fontSize: 18,

                                ///Text weight
                                fontWeight: FontWeight.w800,

                                ///Text decoration
                                decoration: TextDecoration.lineThrough,

                                ///Text spacing
                                letterSpacing: 1,
                              ),
                            )
                          : SizedBox(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        ///Text
                        "${(room.money - room.money * room.discount / 100).toInt()}\đ",

                        ///Text align
                        textAlign: TextAlign.start,

                        ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                        maxLines: 1,

                        style: TextStyle(
                          ///Text size
                          fontSize: 23,

                          ///Text spacing
                          letterSpacing: 1,

                          ///Text color
                          color: AppColors.buttonColor,

                          ///Text weight
                          fontWeight: FontWeight.w900,
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
    );
  }
}
