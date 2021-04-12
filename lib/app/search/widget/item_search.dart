///Note file item_search.dart

import 'package:flutter/material.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';


///class ItemSearch extends StatelessWidget
class ItemSearch extends StatelessWidget {
  final Room room; ///
  ItemSearch(this.room); ///
  @override
  Widget build(BuildContext context) {
    ///GestureDetector
    return GestureDetector(
      onTap: () {
/*        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailHomeStayScreen(room); ///
        }));*/
      },

      child: Container(
        height: 100,                                          ///Container height
        width: double.infinity,                               ///Container width
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),     ///Container margin

        child: Row(
          children: [
            Expanded(
              flex: 2, ///flex
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),  ///Border box decoration
                    image: DecorationImage(
                      image: NetworkImage(room.urlImage),     ///Image
                      fit: BoxFit.cover,                      ///Image fit
                    ),
                ),
              ),
            ),

            Expanded(
              flex: 3, ///flex
              child: Stack(
                alignment: Alignment.topRight, ///alignment
                children: [
                  Container(
                    height: 100, ///Container height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10), ///
                          bottomRight: Radius.circular(10)), ///
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5), ///padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,       ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,  ///Using mainAxisAlignment in a Column will align its children vertically.
                        mainAxisSize: MainAxisSize.min, ///
                        children: [
                          Text(
                            room.nameRoom.toUpperCase(), ///Text import from room name, toUpperCase
                            style: TextStyle(
                                fontWeight: FontWeight.w700, ///Text weight
                                fontSize: 15, ///Text size
                            ),
                          ),

                          Row(
                            children: [
                              Container(
                                height: 25, ///Container height
                                width: 25, ///Container width
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor, ///Color box decoration
                                  borderRadius: BorderRadius.circular(7), ///Border box decoration
                                ),
                                child: Center(
                                  child: Text(
                                    "9.5".toUpperCase(), ///toUpperCase
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600, ///Text weight
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 10,
                              ),

                              Text(
                                "( 200reviews)",
                                style: TextStyle(
                                  color: Colors.grey, ///Text color
                                  fontWeight: FontWeight.w500, ///Text weight
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.location_on, ///Icon
                                color: AppColors.buttonColor, ///Icon color
                                size: 18, ///Icon size
                              ),

                              SizedBox(
                                  width: 10
                              ),

                              Container(
                                width: 150, ///Container width
                                child: Text(
                                  "${room.address}, ${room.city}".toUpperCase(), ///Text address, city from room
                                  maxLines: 2, ///
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
//                    Expanded(
//                      child: Container(
//                        height: 30,
//                        width: double.infinity,
//                        child: ListView.builder(
//                          scrollDirection: Axis.horizontal,
//                          itemBuilder: (context, index) {
//                            return Padding(
//                              padding:
//                                  const EdgeInsets.symmetric(horizontal: 5),
//                              child: Icon(
//                                Icons.location_on,
//                                color: AppColors.buttonColor,
//                              ),
//                            );
//                          },
//                          itemCount: 5,
//                        ),
//                      ),
//                    ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: 80, ///Container width
                    height: 35, ///Container height
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor, ///Color box decoration
                      ///
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${(room.money - room.money * room.discount / 100).toInt()}\đ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,  ///Text weight
                          fontSize: 16,                 ///Text size
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
