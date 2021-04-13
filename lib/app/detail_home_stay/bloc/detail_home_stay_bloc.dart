///Note
import 'package:rxdart/rxdart.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/model/my_home_stay.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
//------------------------------------------------------------------------------
///
class DetailBloc extends BaseBloc {
  /// khai báo stream để lắng nghe kết quả trả về
  BehaviorSubject<MyHomeStay> myHomeStayStream = new BehaviorSubject();

  /// đây là hàm thực thi
  void getMyHomeStay(String id) async {
    try {
      FirAuth().getHomeStayById((val) {
        ///kết quả là val và mình sẽ add vào stream
        myHomeStayStream.add(val);
      }, id);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  /// hàm clear stream sau khi không dùng nữa
  @override
  void dispose() {
    myHomeStayStream.close();
  }

  @override
  void init() {
    // TODO: implement init
  }
}
