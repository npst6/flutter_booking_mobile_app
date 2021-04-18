///Note file fire_base_auth.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_booking_mobile_app/model/room.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';
import 'package:flutter_booking_mobile_app/model/transaction.dart';
import 'package:flutter_booking_mobile_app/model/my_home_stay.dart';
import 'package:flutter_booking_mobile_app/base/flutter_show_toast.dart';

///Declare firebase
class FirAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  final fireStoreInstance = FirebaseFirestore.instance;
  ///SignUp account
  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      prefs.setString("uid", user.user.uid);
      _createUser(user.user.uid, name, phone, user.user.email, onSuccess,
          onRegisterError);
    }).catchError((err) {
      print("err: " + err.toString());
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  ///Create information user by User ID
  _createUser(String userId, String name, String phone, String email,
      Function onSuccess, Function(String) onRegisterError) {
    fireStoreInstance.collection("users").doc(userId).set({
      "name": name,
      "phone": phone,
      "email": email,
      "isActive": 1,
      "permission": 0,
      'avatar': "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Clavulinopsis_sulcata_-_Lane_Cove_River.jpg/1024px-Clavulinopsis_sulcata_-_Lane_Cove_River.jpg",
      'create_day': DateTime.now().millisecondsSinceEpoch
    }).then((_) {
      print("success!");
      onSuccess();
    });

    ///Create transaction history
    fireStoreInstance
        .collection("transaction_history")
        .doc(userId)
        .collection("transaction")
        .add({}).then((_) {
      print("success!");
    });
  }

  ///(SignUp account)
  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "invalid-email":
        onRegisterError("Invalid Email");
        break;
      case "user-not-found":
        onRegisterError("Email does not exist");
        break;
      default:
        onRegisterError("Reset pass fail, please try again");
        break;
    }
  }

  ///SignIn account
  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      prefs.setString("uid", user.user.uid);
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onSignInError("Sign-In fail, please try again");
    });
  }

  ///Take account
  void getUserByUID(Function callBack) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    await fireStoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (firebaseUser.email == element.data()["email"]) {
          Account account = Account.formJson(element.data(), element.id);
          callBack(account);
        }
      });
    });
  }

  ///Update password
  void updatePassword(String pass) {
    var user = FirebaseAuth.instance.currentUser;
    user
        .updatePassword(pass)
        .then((value) => FlutterToast().showToast("Changer pass success"))
        .catchError((e) {
      FlutterToast().showToast(e.code);
    });
  }

  ///Forgot password
  void forgotPassWordByEmail(
      String email, Function onSuccess, Function(String) onSignInError) {
    _fireBaseAuth.sendPasswordResetEmail(email: email).then((doc) {
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      _onResetPass(err.code, (val) {
        print(val);
      });
    });
  }

  ///(Forgot password)
  void _onResetPass(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "invalid-email":
        onRegisterError("Invalid Email");
        break;
      case "user-not-found":
        onRegisterError("Email does not exist");
        break;
      default:
        onRegisterError("reset pass fail, please try again");
        break;
    }
  }

  ///Sign out
  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("signOut");
    prefs.setString("uid", null);
    return _fireBaseAuth.signOut();
  }


  ///Update status room by ID room
  void updateStatusRoomById(int status, String id, Function success) {
    fireStoreInstance
        .collection("room")
        .doc(id)
        .update({"status": status}).then((_) {
      success();
      FlutterToast().showToast("Success");
    });
  }

  ///Delete room
  void deleteRoomById(String id, Function success, Function error) {
    fireStoreInstance.collection("room").doc(id).delete().then((_) {
      success();
      FlutterToast().showToast("Success");
    }).catchError((e) {
      error();
      FlutterToast().showToast(e.message);
    });
  }

  ///Get home stay
  void getHomeStay(Function callBack) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    await fireStoreInstance.collection("home_stay").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (firebaseUser.uid == element.id) {
          MyHomeStay myHomeStay = MyHomeStay.formJson(element.data());
          callBack(myHomeStay);
        }
      });
    });
  }

  ///Get home stay by ID
  void getHomeStayById(Function callBack, String id) async {
    await fireStoreInstance.collection("home_stay").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (id == element.id) {
          MyHomeStay myHomeStay = MyHomeStay.formJson(element.data());
          callBack(myHomeStay);
        }
      });
    });
  }

  ///Get list account
  void getListAccount(Function callBack) async {
    List<Account> listAccount = [];

    await fireStoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        listAccount.add(Account.formJson(element.data(), element.id));
      });
    });
    callBack(listAccount);
  }

  ///Update permissions account
  void updatePermissionAccount(String uid, int permission) {
    fireStoreInstance
        .collection("users")
        .doc(uid)
        .update({"permission": permission}).then((_) {
      FlutterToast().showToast("Success");
    });
  }

  ///Update info account
  void updateInfoAccount(String name, String phone) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    fireStoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({"name": name, "phone": phone}).then((_) {
      FlutterToast().showToast("Success");
    });
  }

  ///Update avatar
  void updateAvatar(String url) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    fireStoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({"avatar": url}).then((_) {
      FlutterToast().showToast("Success");
    });
  }

  ///Create order
  void createOrder(
      String idRoom,
      String checkIn,
      String checkOut,
      int night,
      int numberRoom,
      double totalPrice,
      Function onSuccess,
      Function(String) onRegisterError) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    fireStoreInstance.collection("order").add({
      "id_user": firebaseUser.uid,
      "id_room": idRoom,
      "check_in": checkIn,
      "check_out": checkOut,
      "night": night,
      "status": 0,
      'number_room': numberRoom,
      "total_price": totalPrice,
      'create_day': DateTime.now().toIso8601String()
    }).then((e) {
      onSuccess();
      FlutterToast().showToast("Success");
    });
  }

  ///Update status order
  void updateOrderStatus(int status, String id, Function success) {
    fireStoreInstance
        .collection("order")
        .doc(id)
        .update({"status": status}).then((_) {
      success();
      FlutterToast().showToast("Success");
    });
  }

  ///Create home stay
  void createMyHomeStay(
      String urlImage,
      String name,
      String phone,
      String bankName,
      String bankNumber,
      String accountName,
      Function onSuccess,
      Function(String) onRegisterError) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    fireStoreInstance.collection("home_stay").doc(firebaseUser.uid).set({
      "name": name.toLowerCase(),
      "url_image": urlImage,
      "phone": phone,
      "status": 1,
      'list_review': [],
      "bank": {
        "name": bankName,
        "number": bankNumber,
        "account_name": accountName
      },
      'create_day': DateTime.now().toIso8601String()
    }).then((e) {
      FlutterToast().showToast("Success");
      onSuccess();
    });
  }

  ///Update home stay
  void updateMyHomeStay(
      String urlImage,
      String name,
      String phone,
      String bankName,
      String bankNumber,
      String accountName,
      Function onSuccess,
      Function(String) onRegisterError) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    fireStoreInstance.collection("home_stay").doc(firebaseUser.uid).update({
      "name": name.toLowerCase(),
      "url_image": urlImage,
      "phone": phone,
      "bank": {
        "name": bankName,
        "number": bankNumber,
        "account_name": accountName
      },
    }).then((e) {
      FlutterToast().showToast("Success");
    });
  }

  ///Delete home stay
  void deleteMyHomeStay(Function onSuccess, Function onRegisterError) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    fireStoreInstance.collection("room").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (element.data()["id_hotel"] == firebaseUser.uid) {
          fireStoreInstance
              .collection("room")
              .doc(element.id)
              .delete()
              .then((_) {
            FlutterToast().showToast("Success");
          }).catchError((e) {
            onRegisterError();
            FlutterToast().showToast(e.message);
          });
        }
      });
      fireStoreInstance
          .collection("home_stay")
          .doc(firebaseUser.uid)
          .delete()
          .then((e) {
        FlutterToast().showToast("Success");
        onSuccess();
      }).catchError((e) {
        onRegisterError();
        FlutterToast().showToast(e.message);
      });
    });
  }

  ///Create new room
  void createNewRoom(
      String urlImage,
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
      Function onSuccess,
      Function(String) onRegisterError) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    fireStoreInstance.collection("room").add({
      'name_room': name.toLowerCase(),
      'start_day': startDay,
      'end_day': endDay,
      'status': 1,
      'number_room': 2,
      "number_adults": adults,
      'number_child': child,
      'address': address,
      'city': city.toLowerCase(),
      'desc': desc,
      'create_day': DateTime.now().toIso8601String(),
      'money': price,
      "id_hotel": firebaseUser.uid,
      'url_image': urlImage,
      'service': [1, 2, 3, 4],
      'discount': discount,
    }).then((e) {
      onSuccess();
      FlutterToast().showToast("Success");
    });
  }

  ///Update room
  void updateRoom(
      String urlImage,
      String name,
      String id,
      String startDay,
      String endDay,
      int adults,
      int child,
      String address,
      String city,
      String desc,
      double price,
      double discount,
      Function onSuccess,
      Function(String) onRegisterError) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    fireStoreInstance.collection("room").doc(id).update({
      'name_room': name.toLowerCase(),
      'start_day': startDay,
      'end_day': endDay,
      'status': 1,
      'number_room': 2,
      "number_adults": adults,
      'number_child': child,
      'address': address,
      'city': city.toLowerCase(),
      'desc': desc,
      'create_day': DateTime.now().toIso8601String(),
      'money': price,
      "id_hotel": firebaseUser.uid,
      'url_image': urlImage,
      'service': [1, 2, 3, 4],
      'discount': discount,
    }).then((e) {
      onSuccess();
      FlutterToast().showToast("Success");
    });
  }

  ///Get room by ID
  void getRoomById(Function callBack, String id) async {
    await fireStoreInstance.collection("room").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (id == element.id) {
          Room room = Room.formJson(element.data(), element.id);
          callBack(room);
        }
      });
    });
  }

  ///Get list room by ID room
  void getListRoomByID(Function callBack, {String id}) async {
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      String uid = id ?? firebaseUser.uid;
      List<Room> listRooms = [];

      await fireStoreInstance.collection("room").get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          if (element.data()["id_hotel"] == uid)
            listRooms.add(Room.formJson(element.data(), element.id));
        });
      });
      callBack(listRooms);
    } catch (E) {
      print(E);
    }
  }

  ///Get list room by status
  void getListRoomByStatus(Function callBack, {int status = 1}) async {
    try {
      List<Room> listRooms = [];

      await fireStoreInstance.collection("room").get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          if (element.data()["status"] == status)
            listRooms.add(Room.formJson(element.data(), element.id));
        });
      });
      callBack(listRooms);
    } catch (E) {
      print(E);
    }
  }

  ///Search room
  void searchRoom(
      int numberRoom,
      String startDay,
      String endDay,
      String city,
      double moneyStart,
      double moneyEnd,
      int adults,
      int child,
      Function(List<Room>) callBack) async {
    try {
      List<Room> listRooms = [];
      var result = await fireStoreInstance
          .collection("room")
          .where("status", isEqualTo: 2)
          .where("city", isEqualTo: city.toLowerCase())
          .where("number_adults", isEqualTo: adults)
          .where("number_child", isEqualTo: child)
          .get();
      result.docs.forEach((element) {
        if (element.data()["money"] >= moneyStart &&
            element.data()["money"] <= moneyEnd &&
            element.data()["number_room"] >= numberRoom)
          listRooms.add(Room.formJson(element.data(), element.id));
      });
      callBack(listRooms);
    } catch (e) {
      print(e);
    }
  }

  ///Get list transaction
  void getListTransaction(Function callBack) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    List<Transactions> listTransaction = [];
    await fireStoreInstance.collection("order").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (element.data()["id_user"] == firebaseUser.uid) {
          try {
            listTransaction
                .add(Transactions.formJson(element.data(), element.id));
          } catch (e) {
            print(e);
          }
        }
      });
    });
    callBack(listTransaction);
  }

}
