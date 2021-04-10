///Note file fire_base_auth.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_booking_mobile_app/model/account.dart';


///Declare firebase
class FirAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance; ///
  final fireStoreInstance = FirebaseFirestore.instance; ///

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
  _createUser(
      String userId,
      String name,
      String phone,
      String email,
      Function onSuccess, Function(String) onRegisterError) {
    fireStoreInstance.collection("users").doc(userId).set({
      "name": name,
      "phone": phone,
      "email": email,
      "isActive": 1,
      "permission": 0,
      'avatar': "",
      'create_day': DateTime.now().millisecondsSinceEpoch
    }).then((_) {
      print("success!");
      onSuccess();
    });

    /// tạo lịch sử giao dịch
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
        onRegisterError("reset pass fail, please try again");
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

}