///Note file detail_home_stay.dart

import 'package:rxdart/rxdart.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/model/my_home_stay.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///DetailBloc extends BaseBloc
class DetailBloc extends BaseBloc {
  ///Declare stream to listen to the results returned
  BehaviorSubject<MyHomeStay> myHomeStayStream = new BehaviorSubject();

  void getMyHomeStay(String id) async {
    try {
      FirAuth().getHomeStayById((val) {
        ///Result val and add to stream
        myHomeStayStream.add(val);
      }, id);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Clear stream after use
  @override
  void dispose() {
    myHomeStayStream.close();
  }

  @override
  void init() {
    // TODO: implement init
  }
}
