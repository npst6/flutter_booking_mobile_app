///Note file edit_room_bloc.dart

import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_booking_mobile_app/base/base_bloc.dart';
import 'package:flutter_booking_mobile_app/remote/remote_manager.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';
import 'package:flutter_booking_mobile_app/app/fire_base/fire_base_auth.dart';
import 'package:flutter_booking_mobile_app/remote/province_response/province_response.dart';

///EditRoomBloc extends BaseBloc
class EditRoomBloc extends BaseBloc {
  ///editRoomStateStream
  BehaviorSubject<UIState> editRoomStateStream = new BehaviorSubject();

  ///fileImageStream
  BehaviorSubject<File> fileImageStream = new BehaviorSubject();

  ///listProvinceStream
  BehaviorSubject<List<Province>> listProvinceStream = new BehaviorSubject();

  @override
  void dispose() {
    editRoomStateStream.close();
    fileImageStream.close();
    listProvinceStream.close();
  }

  @override
  void init() {
    _getProvince();
  }

  ///Get list
  void _getProvince() async {
    try {
      listProvinceStream.add([]);
      var tmp = await ManageRemote.provinceService.getAllProvince();
      listProvinceStream.add(tmp);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Get image from library
  void getImageByGallery(ImagePicker picker) async {
    try {
      // ignore: deprecated_member_use
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
      // ignore: deprecated_member_use
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      File _file = File(pickedFile.path);
      fileImageStream.add(_file);
    } catch (e) {
      FlutterToast().showToast(e.message);
    }
  }

  ///Delete room by Id
  void deleteRoomById(String id) {
    try {
      editRoomStateStream.add(UIState.LOADING);
      FirAuth().deleteRoomById(id, () {
        editRoomStateStream.add(UIState.SUCCESS);
      }, () {
        editRoomStateStream.add(UIState.ERROR);
      });
    } catch (e) {
      FlutterToast().showToast(e.message);
      editRoomStateStream.add(UIState.ERROR);
    }
  }

  ///Add room
  void addRoom(
    File file,
    String name,
    String startDay,
    String endDay,
    int adults,
    int child,
    String address,
    String city,
    String desc,
    int numberRoom,
    double price,
    double discount,
  ) async {
    editRoomStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('${Path.basename(file.path)}}');
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FirAuth().createNewRoom(val, name, startDay, endDay, adults, child,
              address, city, desc, price, discount, numberRoom, () {
            editRoomStateStream.add(UIState.SUCCESS);
            FlutterToast().showToast("Success");
          }, (va) {
            editRoomStateStream.add(UIState.ERROR);
            FlutterToast().showToast(va);
          });
        });
      });
    } catch (e) {
      editRoomStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }

  ///Update room have image
  void updateRoomHaveFile(
    File file,
    int numberRoom,
    String id,
    String name,
    String startDay,
    String endDay,
    int adults,
    int child,
    String address,
    String city,
    String desc,
    double price,
    double discount,
  ) async {
    editRoomStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('${Path.basename(file.path)}}');
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FirAuth().updateRoom(val, numberRoom, name, id, startDay, endDay,
              adults, child, address, city, desc, price, discount, () {
            editRoomStateStream.add(UIState.SUCCESS);
            FlutterToast().showToast("Success");
          }, (va) {
            editRoomStateStream.add(UIState.ERROR);
            FlutterToast().showToast(va);
          });
        });
      });
    } catch (e) {
      editRoomStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }

  ///Update room not have image
  void updateRoomNotFile(
    int numberRoom,
    String urlImage,
    String id,
    String name,
    String startDay,
    String endDay,
    int adults,
    int child,
    String address,
    String city,
    String desc,
    double price,
    double discount,
  ) async {
    editRoomStateStream.add(UIState.LOADING);
    try {
      FirAuth().updateRoom(urlImage, numberRoom, name, id, startDay, endDay,
          adults, child, address, city, desc, price, discount, () {
        editRoomStateStream.add(UIState.SUCCESS);
        FlutterToast().showToast("Success");
      }, (va) {
        editRoomStateStream.add(UIState.ERROR);
        FlutterToast().showToast(va);
      });
    } catch (e) {
      editRoomStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.message);
    }
  }
}
