///Note file pop_up_bank_transfer.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_booking_mobile_app/ui/color.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/model/my_home_stay.dart';

///PopUpBankTransfer StatelessWidget
class PopUpBankTransfer extends StatelessWidget {
  ///themeData
  final ThemeData themeData;

  ///myHomeStay
  final MyHomeStay myHomeStay;

  ///totalPrice
  final double totalPrice;

  ///onOK
  final Function onOK;

  PopUpBankTransfer(
      this.themeData, this.myHomeStay, this.totalPrice, this.onOK);

  @override
  Widget build(BuildContext context) {
    return Container(
      ///Container height
      height: 300,

      ///Container width
      width: 300,

      decoration: BoxDecoration(
        ///Color box
        color: themeData.scaffoldBackgroundColor,

        ///Border box
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        ///Using mainAxisAlignment in a Column will align its children vertically.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            ///Container height
            height: 50,

            decoration: BoxDecoration(
              ///Color box
              color: AppColors.primaryColor,

              ///Border box
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),

            child: Center(
              child: Text(
                ///Text
                "Payment 10%",
                style: TextStyle(
                  ///Text size
                  fontSize: 16,

                  ///Text weight
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            ///Padding
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),

            child: Column(
              ///Using crossAxisAlignment in a Column will determines how the children are horizontally aligned in that Column.
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Center(
                  child: Text(
                    ///Text
                    "${totalPrice / 100}\$",

                    style: TextStyle(
                      ///Text color
                      color: AppColors.primaryColor,

                      ///Text size
                      fontSize: 30,

                      ///Text weight
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      ///Text
                      "Bank: ".toUpperCase(),

                      style: TextStyle(
                        ///Text size
                        fontSize: 16,

                        ///Text weight
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      ///Text
                      myHomeStay.bankName.toUpperCase(),

                      style: TextStyle(
                        ///Text size
                        fontSize: 14,

                        ///Text weight
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      ///Text
                      "Name: ".toUpperCase(),

                      style: TextStyle(
                        ///Text size
                        fontSize: 16,

                        ///Text weight
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: Text(
                        ///Text
                        myHomeStay.accountNameBank.toUpperCase(),

                        textAlign: TextAlign.end,

                        style: TextStyle(
                          ///Text size
                          fontSize: 14,

                          ///Text weight
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      ///Text
                      "Bank Number: ".toUpperCase(),

                      style: TextStyle(
                        ///Text size
                        fontSize: 16,

                        ///Text weight
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      ///Text
                      myHomeStay.bankNumber.toUpperCase(),

                      style: TextStyle(
                        ///Text size
                        fontSize: 14,

                        ///Text weight
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Padding(
            ///Padding
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),

            child: Row(
              children: [
                ///Cancel button
                Expanded(
                  child: XButton(
                    "Cancel",
                    () {
                      Navigator.pop(context);
                    },

                    ///Color button
                    color: Colors.grey,

                    ///Height button
                    height: 40,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                ///Ok button
                Expanded(
                  child: XButton(
                    "OK",
                    () {
                      onOK();
                    },
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
