/// Note file home_bloc.dart

import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/base/x_button.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/app/login/login_screen.dart';
import 'package:flutter_booking_mobile_app/remote/remote_manager.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
import 'package:flutter_booking_mobile_app/remote/province_response/province_response.dart';

///HomeBloc extends BaseBloc
class HomeBloc extends BaseBloc {
  ///Declare stream to listen to the results returned
  BehaviorSubject<Account> accountStream = new BehaviorSubject();
  BehaviorSubject<UIState> searchStateStream = new BehaviorSubject();
  BehaviorSubject<List<Room>> listRoomStream = new BehaviorSubject();
  BehaviorSubject<List<Province>> listProvinceStream = new BehaviorSubject();

  ///Clean
  @override
  void dispose() {
    accountStream.close();
    listRoomStream.close();
    listProvinceStream.close();
    searchStateStream.close();
  }

  @override
  void init() {
    getAccount();
    _getProvince();
  }

  void _getProvince() async {
    try {
      listProvinceStream.add([]);
      var tmp = await ManageRemote.provinceService.getAllProvince();
      listProvinceStream.add(tmp);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Home screen search room
  void searchRoom({
    int numberRoom,
    String startDay,
    String endDay,
    String city,
    double moneyStart = 0,
    double moneyEnd = 10000000,
    int adults,
    int child,
  }) {
    try {
      listRoomStream.add([]);
      searchStateStream.add(UIState.LOADING);
      FirAuth().searchRoom(numberRoom, startDay, endDay, city, moneyStart,
          moneyEnd, adults, child, (val) {
        searchStateStream.add(UIState.SUCCESS);
        listRoomStream.add(val);
      });
    } catch (e) {
      searchStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }

  void check(BuildContext context, int active) {
    if (active == 0) {
      showDialog(
        context: context,
        builder: (_) => Scaffold(
          ///backgroundColor
          backgroundColor: Colors.transparent,

          ///body
          body: Center(
            child: Container(
              ///Container height
              height: 150,

              ///Container width
              width: 200,

              decoration: BoxDecoration(
                ///Color box
                color: Colors.white,

                ///Border box
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                ///Padding
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),

                child: Column(
                  ///Using mainAxisAlignment in a Column will align its children vertically.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      ///Text
                      "Logout",
                      style: TextStyle(
                        ///Font size
                        fontSize: 18,

                        ///Font weight
                        fontWeight: FontWeight.w900,

                        ///Font spacing
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      "Do you want to log out?",
                    ),
                    Row(
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
                              FirAuth().signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoginScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  ///Get account from firebase
  void getAccount() async {
    try {
      FirAuth().getUserByUID(
        (Account val) {
          accountStream.add(val);
        },
      );
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }
}
