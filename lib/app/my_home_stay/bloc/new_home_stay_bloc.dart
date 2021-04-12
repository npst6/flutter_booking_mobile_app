///Note
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
//--
// import 'package:bookingapp/model/room.dart';
//------------------------------------------------------------------------------
///
class NewHomeStayBloc extends BaseBloc {
  /// khởi tạo stream
  BehaviorSubject<UIState> newHomeStayStateStream = new BehaviorSubject();
  BehaviorSubject<File> fileImageStream = new BehaviorSubject();

  ///
  @override
  void dispose() {
    newHomeStayStateStream.close();
    fileImageStream.close();
  }

  @override
  void init() {
    getMyHomeStay();
  }

  ///Get home stay
  void getMyHomeStay() async {
    try {
      newHomeStayStateStream.add(UIState.LOADING);
      FirAuth().getHomeStay((val) {});
      newHomeStayStateStream.add(UIState.SUCCESS);
    } catch (e) {
      newHomeStayStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }

  ///Get image from library lấy hình ảnh từ thư viện
  void getImageByGallery(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      File _file = File(pickedFile.path);
      fileImageStream.add(_file);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Get image
  void getImageByCamera(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      File _file = File(pickedFile.path);
      fileImageStream.add(_file);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///
  void addHomeStay(File file, String name, String phone, String bankName,
      String bankNumber, String accountName) async {
    newHomeStayStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
      storage.ref().child('${Path.basename(file.path)}}');
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FirAuth().createMyHomeStay(
              val, name, phone, bankName, bankNumber, accountName, () {
            newHomeStayStateStream.add(UIState.SUCCESS);
            FlutterToast().showToast("Success");
          }, (val) {
            newHomeStayStateStream.add(UIState.ERROR);
            FlutterToast().showToast(val);
          });
        });
      });
    } catch (e) {
      newHomeStayStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }
}
