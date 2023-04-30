import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokee/models/user_model.dart';
import 'package:pokee/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui/screens/auth/verification.dart';

class AuthProvider extends ChangeNotifier{
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthProvider(){
    checkSignIn();
  }

  void checkSignIn() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try{
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async{
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error){
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => VerifyOTP(verificationId: verificationId)));
        }, 
        codeAutoRetrievalTimeout: (verificationId){
          showSnackBar(context, "Time out");
        },
        );

    } on FirebaseAuthException catch (e){
      showSnackBar(context, e.message.toString());
    }
  }

  void otpVerification({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
    required Function onSuccess,
    }) async {
      _isLoading = true;
      notifyListeners();
      try{
        PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
        User user = (await _firebaseAuth.signInWithCredential(creds)).user!;
        if(user!=null){
          _uid = user.uid;
          onSuccess();
        }
        _isLoading = false;
        notifyListeners();
      } on FirebaseAuthException catch (e){
        showSnackBar(context, e.message.toString());
        _isLoading = false;
        notifyListeners();
      }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot = await _firestore.collection("users").doc(_uid).get();
    if(snapshot.exists){
      return true;
    }
    else{
      return false;
    }
  }

  void saveUserData({
    required BuildContext context,
    required UserModel userModel,
    required Function onSucess}) async {
      _isLoading = true;
      notifyListeners();
      try{
        userModel.uid = _firebaseAuth.currentUser!.uid;
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        _userModel = userModel;
        await _firestore.collection("users").doc(_uid).set(userModel.toMap()).then((value) {
          onSucess();
          _isLoading = false;
          notifyListeners();
        });
      } on FirebaseAuthException catch (e){
        showSnackBar(context, e.toString());
        _isLoading = false;
        notifyListeners();
      }
  }

  Future saverUserDataLocally() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getUserDataLocally() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? "";
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid; 
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

  Future getDataFromFirestore() async {
    await _firestore.collection("users").doc(_firebaseAuth.currentUser!.uid).get().then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        firstname: snapshot["firstname"],
        lastname: snapshot["lastname"],
        username: snapshot["username"],
        phoneNumber: snapshot["phoneNumber"],
        uid: snapshot["uid"]);
      _uid = userModel.uid;
    });
    notifyListeners();
  }
}