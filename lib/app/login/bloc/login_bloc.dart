import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc {
  /// khởi tạo stream
  BehaviorSubject<UIState> loginStream = new BehaviorSubject();
  @override
  void dispose() {
    loginStream.close();
  }
  @override
  void init() {}
  /// hàm login
  void login({String email, String pass}) {
    loginStream.add(UIState.LOADING);
    FirAuth().signIn(email, pass, () {
      loginStream.add(UIState.SUCCESS);
      FlutterToast().showToast("Login success");
    }, (val) {
      loginStream.add(UIState.ERROR);
      FlutterToast().showToast(val);
    });
  }
}
