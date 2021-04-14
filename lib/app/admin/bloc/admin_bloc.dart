///Note file admin_bloc.dart

import 'package:rxdart/rxdart.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///AdminBloc to receive data and manipulate the UI
class AdminBloc extends BaseBloc {
  ///Initialization
  BehaviorSubject<List<Account>> accountStream = new BehaviorSubject();
  BehaviorSubject<List<Room>> listRoomStream = new BehaviorSubject();

  ///Close
  @override
  void dispose() {
    accountStream.close();
    listRoomStream.close();
  }

  @override
  void init() {
    _getAllAccount();
    getMyRoom();
  }

  ///Get all account
  void _getAllAccount() async {
    try {
      FirAuth().getListAccount((val) {
        accountStream.add(val);
      });
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Update Permission
  void updatePermission(String uid, int permission) {
    try {
      FirAuth().updatePermissionAccount(uid, permission);
      _getAllAccount();
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Get my room
  void getMyRoom() async {
    try {
      FirAuth().getListRoomByStatus((val) {
        listRoomStream.add(val);
      });
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Update status room approved or canceled
  void updateStatusRoomById(String id, int status) async {
    try {
      FirAuth().updateStatusRoomById(status, id, () {
        getMyRoom();
      });
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }
}
