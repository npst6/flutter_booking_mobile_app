///Note file edit_home_stay_bloc.dart

import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

///EditHomeStayBloc extends BaseBloc
class EditHomeStayBloc extends BaseBloc {
  ///editHomeStayStateStream
  BehaviorSubject<UIState> editHomeStayStateStream = new BehaviorSubject();

  ///fileImageStream
  BehaviorSubject<File> fileImageStream = new BehaviorSubject();

  @override
  void dispose() {
    editHomeStayStateStream.close();
    fileImageStream.close();
  }

  @override
  void init() {
    getMyHomeStay();
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

  ///Get list home stay
  void getMyHomeStay() async {
    try {
      editHomeStayStateStream.add(UIState.LOADING);
      FirAuth().getHomeStay((val) {});
      editHomeStayStateStream.add(UIState.SUCCESS);
    } catch (e) {
      editHomeStayStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }

  ///Edit home stay have image
  void editHomeStayHaveFile(File file, String name, String phone,
      String bankName, String bankNumber, String accountName) async {
    editHomeStayStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('${Path.basename(file.path)}');
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FirAuth().updateMyHomeStay(
              val, name, phone, bankName, bankNumber, accountName, () {
            editHomeStayStateStream.add(UIState.SUCCESS);
            FlutterToast().showToast("Success");
          }, (val) {
            editHomeStayStateStream.add(UIState.ERROR);
            FlutterToast().showToast(val);
          });
        });
      });
    } catch (e) {
      editHomeStayStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }

  ///Edit home stay don't have image
  void editHomeStayNotFile(String urlImage, String name, String phone,
      String bankName, String bankNumber, String accountName) async {
    editHomeStayStateStream.add(UIState.LOADING);
    try {
      FirAuth().updateMyHomeStay(
          urlImage, name, phone, bankName, bankNumber, accountName, () {
        editHomeStayStateStream.add(UIState.SUCCESS);
        FlutterToast().showToast("Success");
      }, (val) {
        editHomeStayStateStream.add(UIState.ERROR);
        FlutterToast().showToast(val);
      });
    } catch (e) {
      editHomeStayStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }

  ///Delete home stay
  void deleteHomeStay() async {
    editHomeStayStateStream.add(UIState.LOADING);
    try {
      FirAuth().deleteMyHomeStay(() {
        editHomeStayStateStream.add(UIState.SUCCESS);
        FlutterToast().showToast("Success");
      }, () {
        editHomeStayStateStream.add(UIState.ERROR);
      });
    } catch (e) {
      editHomeStayStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }
}
