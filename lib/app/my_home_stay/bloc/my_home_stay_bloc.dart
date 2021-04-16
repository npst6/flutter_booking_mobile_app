///Note file my_home_stay_bloc.dart

import 'package:rxdart/rxdart.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/model/my_home_stay.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///HomeStayBloc extends BaseBloc
class HomeStayBloc extends BaseBloc {
  ///Declare stream to listen to the results returned
  ///myHomeStayStream
  BehaviorSubject<MyHomeStay> myHomeStayStream = new BehaviorSubject();
  ///myHomeStayStateStream
  BehaviorSubject<UIState> myHomeStayStateStream = new BehaviorSubject();
  ///listRoomStream
  BehaviorSubject<List<Room>> listRoomStream = new BehaviorSubject();

  ///Clean
  @override
  void dispose() {
    myHomeStayStream.close();
    myHomeStayStateStream.close();
    listRoomStream.close();
  }

  @override
  void init() {
    getMyHomeStay();
    getMyRoom();
  }

  ///Get home stay
  void getMyHomeStay() async {
    try {
      myHomeStayStateStream.add(UIState.LOADING);
      FirAuth().getHomeStay((val) {
        myHomeStayStream.add(val);
      });
      myHomeStayStateStream.add(UIState.SUCCESS);
    } catch (e) {
      myHomeStayStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }

  ///Get room
  void getMyRoom() async {
    try {
      listRoomStream.add([]);
      FirAuth().getListRoomByID((val) {
        listRoomStream.add(val);
      });
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }
}
