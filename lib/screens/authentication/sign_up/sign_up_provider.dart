import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lensme/models/customer_model.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:lensme/shared/cashe_helper.dart';
import 'package:lensme/shared/constants.dart';

class SignUpProvider with ChangeNotifier {

  bool isSignUpButtonLoading = false;

  Future<String> customerSignUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      isSignUpButtonLoading = true;
      notifyListeners();
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final result = await customerCreate(
          name: name,
          email: email,
          phone: phone,
          password: password,
          customerId: user.user!.uid
      );
      Id = user.user!.uid;
      if (result == 'success') {
        await CacheHelper.saveData(key: 'Id', value: user.user!.uid);
        await CacheHelper.putBoolean(key: 'isPhotographer', value: false);
        isSignUpButtonLoading = false;
        notifyListeners();
        return 'success';
      }
      return 'success';
    } catch (e) {
      isSignUpButtonLoading = false;
      notifyListeners();
      print(e.toString());
      if(e.toString() =='[firebase_auth/weak-password] Password should be at least 6 characters')
      {
        return 'Weak Password';
      }
      if(e.toString() =='[firebase_auth/invalid-email] The email address is badly formatted.')
      {
        return 'Please Enter Valid Email';
      }
      if(e.toString() =='[firebase_auth/email-already-in-use] The email address is already in use by another account.')
        {
          return 'The email address is already exist';
        }
      return 'Error in FirebaseAuth';
    }
  }


  Future<String> customerCreate({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String customerId,
  }) async {
    CustomerModel modelCustomer = CustomerModel(
      name: name,
      email: email,
      phone: phone,
      password: password,
      customerId: customerId,
      favorites:[],
      isPhotographer:false,
      rate:{},
    );
    try {
      await FirebaseFirestore.instance.collection('customers').doc(customerId).set(modelCustomer.toMap());
      await FirebaseFirestore.instance.collection('emails').doc(customerId).set(modelCustomer.mapTypeUser());
      return 'success';
    } catch (e) {
      print('error2');
      print(e.toString());
      return 'error';
    }
  }



  Future<String> photographerSignUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      isSignUpButtonLoading = true;
      notifyListeners();
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final result = await photographerCreate(
          name: name,
          email: email,
          phone: phone,
          password: password,
          photographerId: user.user!.uid
      );
      Id = user.user!.uid;
      if (result == 'success') {
        await CacheHelper.saveData(key: 'Id', value: user.user!.uid);
        await CacheHelper.putBoolean(key: 'isPhotographer', value: true);
        isSignUpButtonLoading = false;
        notifyListeners();
      }
      return 'success';
    } catch (e) {
      isSignUpButtonLoading = false;
      notifyListeners();
      if(e.toString() =='[firebase_auth/weak-password] Password should be at least 6 characters')
      {
        return 'Weak Password';
      }
      if(e.toString() =='[firebase_auth/invalid-email] The email address is badly formatted.')
      {
        return 'Please Enter Valid Email';
      }
      if(e.toString() =='[firebase_auth/email-already-in-use] The email address is already in use by another account.')
      {
        return 'The email address is already exist';
      }
      return 'Error in FirebaseAuth';
    }
  }


  Future<String> photographerCreate({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String photographerId,
  }) async {
    PhotographerModel modelPhotographer = PhotographerModel(
      name: name,
      email: email,
      phone: phone,
      shootingTypes:[],
      locations:[],
      dislike: 0,
      like: 0,
      experienceYears:'',
      gallery: [
        'https://img.discogs.com/OAwSHqdnbBPHzyCULjhIk1_O7f8=/300x300/filters:strip_icc():format(jpeg):quality(40)/discogs-avatars/U-6234876-1552313744.jpeg.jpg',
        'https://img.discogs.com/OAwSHqdnbBPHzyCULjhIk1_O7f8=/300x300/filters:strip_icc():format(jpeg):quality(40)/discogs-avatars/U-6234876-1552313744.jpeg.jpg',
        'https://img.discogs.com/OAwSHqdnbBPHzyCULjhIk1_O7f8=/300x300/filters:strip_icc():format(jpeg):quality(40)/discogs-avatars/U-6234876-1552313744.jpeg.jpg',
      ],
      initialPrice: 0,
      profilePicture: 'https://img.discogs.com/OAwSHqdnbBPHzyCULjhIk1_O7f8=/300x300/filters:strip_icc():format(jpeg):quality(40)/discogs-avatars/U-6234876-1552313744.jpeg.jpg',
      offer:'',
      socialLinks: ['','',''],
      freeTimes: [],
      password: password,
      photographerId: photographerId,
      isPhotographer:true,
    );
    try {
      await FirebaseFirestore.instance.collection('photographers').doc(photographerId).set(modelPhotographer.toMap());
      await FirebaseFirestore.instance.collection('emails').doc(photographerId).set(modelPhotographer.mapTypeUser());
      return 'success';
    } catch (e) {
      print('error2');
      print(e.toString());
      return 'error';
    }
  }


  bool isPhotographer=false;

  changeIsPhotographer(value){
    isPhotographer=value;
    notifyListeners();
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