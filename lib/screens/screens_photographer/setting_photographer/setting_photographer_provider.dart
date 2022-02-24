import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lensme/models/appointment_model.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lensme/shared/constants.dart';
import 'package:lensme/shared/my_calender/my_calender/meeting.dart';

class SettingPhotographerProvider with ChangeNotifier{

  List<String> listLocations =[
    'Ajlon', 'Amman', 'Aqaba', 'Balqa', 'Irbid', 'Jarash', 'Karak',
    'Ma\'an', 'Madaba', 'Mafraq', 'Tafeleh', 'Zarqa',
  ];

  List<String> listShootingTypes =[
    'Wedding','Graduation','Personal','Food','Natural','Party', 'Video Photography',
    'Cinematography','Baby Photography','MakeUp Photography',
  ];

  PhotographerModel? photographerModel;
  List<String>?gallery;

  Future getPhotographerData(
      //{String? id,}
) async {

    final data = await FirebaseFirestore.instance.collection('photographers').doc(/*id??*/Id).get();
    notifyListeners();
    photographerModel = PhotographerModel.fromJson(data.data()!);
    //print(data.data()!.values);
    print(photographerModel!.initialPrice);
    photographerModel!.locations!.forEach((element) {
      print(element);
    });
    gallery= photographerModel!.gallery;
    notifyListeners();
    getAppointment(photographerId: photographerModel!.photographerId!);
    return 'success';
  }

  final ImagePicker picker = ImagePicker();
  String profileImage = '';

  Future<File?> pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }

  Future<String?> pickProfileImage() async {
    profileImage = (await pickImage())?.path ?? '';
    print(profileImage);
    notifyListeners();

  }

  Future<String> uploadProfileImage(File image) async {
    try {
      if (photographerModel != null) {
        final firebaseFile = await firebase_storage.FirebaseStorage.instance.ref().child('photographers/profile_picture/${photographerModel!.photographerId}').putFile(image);
        //final firebaseFile = await firebase_storage.FirebaseStorage.instance.ref().child('Photographers/${Uri.file(profileImage)}').putFile(image);
        profileImage = await firebaseFile.ref.getDownloadURL();
        print('success');
        print(profileImage);
        print('success');
        return 'success';
      }
      print('Profile error1');
      return 'error';
    } catch (e) {
      print('Profile error2');
      print( e.toString());
      return e.toString();
    }
  }

  String galleryImage = '';

  Future<String?> pickGalleryImage() async {
    galleryImage = (await pickImage())?.path ?? '';
    print(galleryImage);
    print('123');
    notifyListeners();

  }

  Future<String> uploadGalleryImage(File image) async {
    try {
      if (photographerModel != null) {
        final firebaseFile = await firebase_storage.FirebaseStorage.instance.ref().child('photographers/gallery/${photographerModel!.photographerId}').putFile(image);
        //final firebaseFile = await firebase_storage.FirebaseStorage.instance.ref().child('Photographers/${Uri.file(profileImage)}').putFile(image);
        gallery!.add(await firebaseFile.ref.getDownloadURL());
        print('success');
        print(gallery);
        print('success');
        return 'success';
      }
      print('secses');
      return 'secses';
    } catch (e) {
      print('Galleryerror2');
      print( e.toString());
      return e.toString();
    }
  }


  Future<String> updateGallery() async {
    try {
      await uploadGalleryImage(File(galleryImage),);
      photographerModel!.gallery=gallery;
      await FirebaseFirestore.instance.collection('photographers').doc(Id).set(photographerModel!.toMap());
      await getPhotographerData();
      //galleryImage='';
      notifyListeners();
      return 'success';
    } catch (e) {
      print('fdgdfgdgfdgd');
      print(e.toString());
      return e.toString();
    }
  }

  removeGallery({
    required int index,
}) async {
    gallery!.removeAt(index);
    photographerModel!.gallery=gallery;
    await FirebaseFirestore.instance.collection('photographers').doc(Id).set(photographerModel!.toMap());
    await getPhotographerData();
    notifyListeners();

  }


   bool isPageLoading = false;

  Future<String> updatePhotographer({
    required String name,
    required String phone,
    required int initialPrice,
    required List<String> locations,
    required List<String> shootingTypes,
    required List<String> socialLinks,
    required String pExperience,
    required String offer,
    List<String>? freeTimes,
  }) async {
    try {
      if (photographerModel == null) throw Exception('userModel cannot be null');
      isPageLoading = true;
      notifyListeners();
        await uploadProfileImage(File(profileImage),);
      PhotographerModel model = PhotographerModel(
        name: name,
        email: photographerModel!.email,
        phone: phone,
        initialPrice:initialPrice,
        locations: locations,
        shootingTypes: shootingTypes,
        experienceYears: pExperience,
        password: photographerModel!.password,
        like:photographerModel!.like,
        dislike: photographerModel!.dislike,
        gallery: photographerModel!.gallery,
        freeTimes: freeTimes,
        socialLinks:socialLinks,
        offer: offer,
        profilePicture: profileImage.isNotEmpty? profileImage : photographerModel!.profilePicture,//profileImage.isEmpty? photographerModel!.profilePicture:profileImage,
        photographerId: photographerModel!.photographerId,
        isPhotographer: true,
       // freeTimes: photographerModel!.freeTimes,
      );
      await FirebaseFirestore.instance.collection('photographers').doc(Id).set(model.toMap());
      await getPhotographerData();
      notifyListeners();
      isPageLoading = false;
      profileImage = '';
      notifyListeners();
      return 'success';
    } catch (e) {
      isPageLoading = false;
      notifyListeners();
      print(e.toString());
      return e.toString();
    }
  }


  late AppointmentModel appointmentModel;
  List<AppointmentModel> appointments=[];

  bool not=true;
  changeNotFalse(){
    not=false;
  }
  changeNotTrue(){
    not=true;
  }

  getAppointment({
    required String photographerId,
}) async {
    appointments = [];
    await FirebaseFirestore.instance.collection('appointments').get().then((value){
      value.docs.forEach((element) {
        if(element.data()['photographerId'] == photographerId) {
          appointments.add(AppointmentModel.fromJson(element.data()));
          print(element.data()['appointmentTime']);
        }
      });
    });
    appointments.sort((a,b)=>a.appointmentTime!.compareTo(b.appointmentTime!));
    notifyListeners();
  }

  removeAppointment({
    required String photographerId,
    required String appointmentTime,
  }) async {
    try{
      String appointmentId ='';
      await FirebaseFirestore.instance.collection('appointments').get().then((value){
        value.docs.forEach((element) {
          if(element.data()['photographerId'] == photographerId
              && element.data()['appointmentTime'] == appointmentTime) {
            appointmentId=element.id;
          }
        });
      });
      notifyListeners();
      await FirebaseFirestore.instance.collection('appointments').doc(appointmentId).delete();
      await getAppointment(photographerId:photographerId );
      List<Meeting>meetings=[];
      photographerModel!.freeTimes!.add(appointmentTime);
      photographerModel!.freeTimes!.sort();
      meetings=(photographerModel!.freeTimes!).map((e) => Meeting.fromString(e)).toList();
      updateFreeTimes(freeTimes: meetings.map((e) => e.toString()).toList());
      notifyListeners();
      return 'remove';
    } catch(e){
      print(e.toString());
      return 'notRemove';
    }
  }


  addTimeAppointment({
    required String freeTime,
}) async {
    if(photographerModel!.freeTimes!.contains(freeTime))
      {
        photographerModel!.freeTimes!.remove(freeTime);
      }else{
      photographerModel!.freeTimes!.add(freeTime);
    }
    photographerModel!.freeTimes!.sort();
    await FirebaseFirestore.instance.collection('photographers').doc(Id).set(photographerModel!.toMap());
    notifyListeners();

  }

  Future<String> updateFreeTimes({
    required List<String> freeTimes,
  }) async {
    try {

      print('maaaaaa');
      print(freeTimes[0]);
      photographerModel!.freeTimes=freeTimes;
      await FirebaseFirestore.instance.collection('photographers').doc(Id).set(photographerModel!.toMap());
      await getPhotographerData();
      notifyListeners();
      print('hi2');
      return 'success';
    } catch (e) {
      print(e.toString());
      print('hi');
      return e.toString();
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  changePasswordVisibility(){
    isPassword=!isPassword;
    if(isPassword==true)
    {suffix = Icons.visibility_outlined;}
    if(isPassword==false)
    {suffix = Icons.visibility_off_outlined;}
    notifyListeners();
  }

}