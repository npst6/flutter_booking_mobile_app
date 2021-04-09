///Note file register_bloc.dart

import 'package:rxdart/rxdart.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///class RegisterBloc extends BaseBloc
class RegisterBloc extends BaseBloc {
  BehaviorSubject<UIState> registerStream = new BehaviorSubject(); ///
  @override
  void dispose() {
    registerStream.close(); ///
  }

  @override
  void init() {}

  ///Register acount
  void register({String email, String pass, String name, String phone}) {
      registerStream.add(UIState.LOADING);
      FirAuth().signUp(email, pass, name, phone, () {
      registerStream.add(UIState.SUCCESS);
      FlutterToast().showToast("Register successfully");
    }, (val) {
      registerStream.add(UIState.ERROR);
      FlutterToast().showToast(val);
    });
  }
}
