/// Note
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

///
class HomeBloc extends BaseBloc {
  /// khai báo stream để lắng nghe kết quả trả về
  BehaviorSubject<Account> accountStream = new BehaviorSubject();
  BehaviorSubject<UIState> searchStateStream = new BehaviorSubject();
  BehaviorSubject<List<Room>> listRoomStream = new BehaviorSubject();
  BehaviorSubject<List<Province>> listProvinceStream = new BehaviorSubject();
  /// hàm clean
  @override
  void dispose() {
    accountStream.close();
    listRoomStream.close();
    listProvinceStream.close();
    searchStateStream.close();
  }
  /// Note
  @override
  void init() {
    getAccount();
    _getProvince();
  }
  /// Note
  void _getProvince() async {
    try {
      listProvinceStream.add([]);
      var tmp = await ManageRemote.provinceService.getAllProvince();
      listProvinceStream.add(tmp);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  /// Note
  void check(BuildContext context, int active) {
    if (active == 0) {
      showDialog(
        context: context,
        builder: (_) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ///Using mainAxisAlignment in the Row allows you to align the row widgets horizontally (left, right).
                  ///Using mainAxisAlignment in a Column will align its children vertically (top, bottom).
                  children: [
                    Text(
                      "Logout",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,  ///Font size
                          fontSize: 18, ///Font size
                          letterSpacing: 1),
                    ),
                    Text(
                      "Do you want to log out?",
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: MButton(
                            "Cancel", () {Navigator.pop(context);},
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: MButton(
                            "OK",
                                () {
                              FirAuth().signOut();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                  }));
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
  /// Note
  void getAccount() async {
    try {
      FirAuth().getUserByUID((Account val) {
        accountStream.add(val);
      });
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }
}
