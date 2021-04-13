///Note file new_home_stay_bloc.dart

import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///NewHomeStayBloc extends BaseBloc
class NewHomeStayBloc extends BaseBloc {
  ///Initialization stream
  BehaviorSubject<UIState> newHomeStayStateStream = new BehaviorSubject();
  BehaviorSubject<File> fileImageStream = new BehaviorSubject();

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

  ///Get image from library
  void getImageByGallery(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      File _file = File(pickedFile.path);
      fileImageStream.add(_file);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Get image from camera
  void getImageByCamera(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      File _file = File(pickedFile.path);
      fileImageStream.add(_file);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Add home stay
  void addHomeStay(File file, String name, String phone, String bankName,
      String bankNumber, String accountName) async {
    newHomeStayStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      FirAuth().createMyHomeStay(
          "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg", name, phone, bankName, bankNumber, accountName, () {
        newHomeStayStateStream.add(UIState.SUCCESS);
        FlutterToast().showToast("Success");
      }, (val) {
        newHomeStayStateStream.add(UIState.ERROR);
        FlutterToast().showToast(val);
      });
      // Reference storageReference =
      // storage.ref().child('${Path.basename(file.path)}}');
      // await storageReference.putFile(file).then((val) {
      //   val.ref.getDownloadURL().then((val) {
      //
      //   });
      // });
    } catch (e) {
      newHomeStayStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }
}
