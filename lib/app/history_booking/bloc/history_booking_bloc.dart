///Note file history_booking_bloc.dart

import 'package:rxdart/rxdart.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/model/transaction.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///HistoryBookingBloc extends BaseBloc
class HistoryBookingBloc extends BaseBloc {
  ///Initialization stream
  BehaviorSubject<List<Transactions>> historyBookingStream1 =
      new BehaviorSubject();
  BehaviorSubject<List<Transactions>> historyBookingStream2 =
      new BehaviorSubject();
  BehaviorSubject<List<Transactions>> historyBookingStream3 =
      new BehaviorSubject();
  BehaviorSubject<List<Transactions>> historyBookingStream4 =
      new BehaviorSubject();
  BehaviorSubject<UIState> historyBookingStateStream = new BehaviorSubject();
  BehaviorSubject<Room> myRoomStream = new BehaviorSubject();

  ///Get room by id
  void getRoom(String id) async {
    try {
      FirAuth().getRoomById((val) {
        myRoomStream.add(val);
      }, id);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Clear stream
  @override
  void dispose() {
    historyBookingStateStream.close();
    historyBookingStream1.close();
    historyBookingStream2.close();
    historyBookingStream3.close();
    historyBookingStream4.close();
    myRoomStream.close();
  }

  @override
  void init() {
    getHistoryBooking();
  }

  ///Get history booking
  void getHistoryBooking() async {
    List<Transactions> history1 = [];
    List<Transactions> history2 = [];
    List<Transactions> history3 = [];
    List<Transactions> history4 = [];
    historyBookingStateStream.add(UIState.LOADING);
    try {
      FirAuth().getListTransaction((val) {
        val.forEach((element) {
          switch (element.status) {
            case 0:
              history1.add(element);
              break;
            case 1:
              history2.add(element);
              break;
            case 2:
              history3.add(element);
              break;
            case 3:
              history4.add(element);
              break;
          }
        });
      });
      historyBookingStream1.add(history1);
      historyBookingStream2.add(history2);
      historyBookingStream3.add(history3);
      historyBookingStream4.add(history4);
      historyBookingStateStream.add(UIState.SUCCESS);
    } catch (e) {
      historyBookingStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }
}
