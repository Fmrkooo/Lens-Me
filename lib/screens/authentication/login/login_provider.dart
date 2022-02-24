import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lensme/shared/cashe_helper.dart';
import 'package:lensme/shared/constants.dart';

class LoginProvider with ChangeNotifier{

  bool isLoginButtonLoading = false;
  Future<String> loginWithEmailAndPassword({required String email, required String password}) async {
    try {
      isLoginButtonLoading = true;
      notifyListeners();
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Id=userCredential.user!.uid;
      await CacheHelper.saveData(key: 'Id', value: FirebaseAuth.instance.currentUser?.uid);
      final data = await FirebaseFirestore.instance.collection('emails').doc(Id).get();
      await CacheHelper.putBoolean(key:'isPhotographer', value: data['isPhotographer']);
      isLoginButtonLoading = false;
      notifyListeners();
      return 'success';
    } catch (e) {
      isLoginButtonLoading = false;
      notifyListeners();
      print(e.toString());
      if(e.toString() =='[firebase_auth/wrong-password] The password is invalid or the user does not have a password.')
        {
          return 'Incorrect Password';
        }
      if(e.toString() =='[firebase_auth/invalid-email] The email address is badly formatted.')
      {
        return 'Please Enter Valid Email';
      }
      if(e.toString() =='[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.')
      {
        return 'There is No Account With This Email';
      }
      return 'e.toString()';

    }
  }


  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  changePasswordVisibility(){
    isPassword=!isPassword;
    if(isPassword==true)
    {suffix = Icons.visibility_off_outlined;}
    if(isPassword==false)
    {suffix = Icons.visibility_outlined;}
    notifyListeners();
  }
}