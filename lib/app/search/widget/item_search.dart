///Note file item_search.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/app/detail_home_stay/detail_home_stay_screen.dart';

///ItemSearch StatelessWidget
class ItemSearch extends StatelessWidget {
  ///room
  final Room room;

  ItemSearch(
    this.room,
  );

  @override
  Widget build(BuildContext context) {
    ///GestureDetector
    return GestureDetector(
      ///onTap
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailHomeStayScreen(room);
            },
          ),
        );
      },

      child: Container(
        ///Container height
        height: 100,

        ///Container width
        width: double.infinity,

        ///Container margin
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),

        child: Row(
          children: [
            Expanded(
              ///Flex
              flex: 2,

              child: Container(
                decoration: BoxDecoration(
                  ///Border box
                  borderRadius: BorderRadius.circular(20),

                  image: DecorationImage(
                    ///Image
                    image: NetworkImage(room.urlImage),

                    ///Image fit
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              ///Flex
              flex: 3,

              child: Stack(
                ///Alignment
                alignment: Alignment.topRight,

                children: [
                  Container(
                    ///Container height
                    height: 100,

                    decoration: BoxDecoration(
                      ///Border box
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),

                    child: Padding(
                      ///Padding
                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),

                      child: Column(
                        ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                        crossAxisAlignment: CrossAxisAlignment.start,

                        ///Using mainAxisAlignment in a Column will align its children vertically.
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        ///Use mainAxisSize to pack the child of a row or columns together.
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Text(
                            ///Text import from room name, toUpperCase
                            room.nameRoom.toUpperCase(),
                            style: TextStyle(
                              ///Text weight
                              fontWeight: FontWeight.w700,

                              ///Text size
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                ///Container height
                                height: 25,

                                ///Container width
                                width: 25,

                                decoration: BoxDecoration(
                                  ///Color box decoration
                                  color: AppColors.primaryColor,

                                  ///Border box decoration
                                  borderRadius: BorderRadius.circular(7),
                                ),

                                child: Center(
                                  child: Text(
                                    ///Text, toUpperCase
                                    "9.5".toUpperCase(),

                                    style: TextStyle(
                                      ///Text weight
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                ///Text
                                "( 200reviews)",

                                style: TextStyle(
                                  ///Text color
                                  color: Colors.grey,

                                  ///Text weight
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
                              Container(
                                ///Container width
                                width: 150,

                                child: Text(
                                  ///Text
                                  "${room.address}, ${room.city}".toUpperCase(),

                                  ///Used maxLines to determine the maximum display number of text if the text number is exceeded with maxLines, it will be shortly cut based on the overflow attribute.
                                  maxLines: 2,

                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    ///Container width
                    width: 80,

                    ///Container height
                    height: 35,

                    decoration: BoxDecoration(
                      ///Color box
                      color: AppColors.primaryColor,

                      ///Border box
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),

                    child: Center(
                      child: Text(
                        ///Text
                        "${(room.money - room.money * room.discount / 100).toInt()}\đ",

                        style: TextStyle(
                          ///Text weight
                          fontWeight: FontWeight.bold,

                          ///Text size
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
