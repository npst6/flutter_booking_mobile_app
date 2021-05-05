///Note file profile_bloc.dart

import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';

class ProfileBloc extends BaseBloc {
  ///Initialize stream
  ///Account
  BehaviorSubject<Account> accountStream = new BehaviorSubject();

  ///UIState
  BehaviorSubject<UIState> accountStateStream = new BehaviorSubject();

  ///File Image
  BehaviorSubject<File> fileIamgeStream = new BehaviorSubject();

  @override
  void dispose() {
    accountStream.close();
    accountStateStream.close();
    fileIamgeStream.close();
  }

  @override
  void init() {
    _getAccount();
  }

  ///Get account
  void _getAccount() async {
    try {
      accountStateStream.add(UIState.LOADING);
      FirAuth().getUserByUID((val) {
        accountStream.add(val);
      });
      accountStateStream.add(UIState.SUCCESS);
    } catch (e) {
      accountStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }

  ///Get image from library
  void getImageByGallery(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      File _file = File(pickedFile.path);
      fileIamgeStream.add(_file);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Get image from camera
  void getImageByCamera(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      File _file = File(pickedFile.path);
      fileIamgeStream.add(_file);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Update information account
  void updateInfoAccount(String name, String phone, String pass) {
    try {
      FirAuth().updateInfoAccount(name, phone);
      if (pass != "") {
        FirAuth().updatePassword(pass);
      }
      _getAccount();
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Update avatar account
  void updateImageAvatar(File file) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('${Path.basename(file.path)}}');
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FirAuth().updateAvatar(val);
        });
      });
      _getAccount();
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }
}
