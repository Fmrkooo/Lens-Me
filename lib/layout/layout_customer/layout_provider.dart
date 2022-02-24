import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:lensme/screens/screens_customer/favorite_customer/favorite_customer_screen.dart';
import 'package:lensme/screens/screens_customer/home_customer/home_customer_screen.dart';
import 'package:lensme/screens/screens_customer/notification_customer/notification_customer_screen.dart';
import 'package:lensme/screens/screens_customer/setting_customer/setting_customer_screen.dart';
import 'package:lensme/shared/my_calender/my_calender/meeting.dart';

class LayoutProvider with ChangeNotifier{


  int currentIndex = 0;

  List<Widget> bottomScreens = [
    HomeCustomerScreen(),
    FavoriteCustomerScreen(),
    NotificationCustomerScreen(),
    SettingCustomerScreen(),
  ];

  List<String>appBarTitle = [
    'Home',
    'Favorites',
    'Notifications',
    'Settings',
  ];

  List<PhotographerModel> photographersData =[];
  List<PhotographerModel> photographersDataSortLike =[];
  List<PhotographerModel> photographersDataOffer =[];

  Future getPhotographersData() async {
    photographersData = [];
    photographersDataSortLike=[];
    photographersDataOffer=[];
    await FirebaseFirestore.instance.collection('photographers').get().then((value){
      value.docs.forEach((element) {
        photographersData.add(PhotographerModel.fromJson(element.data()));
        if(element.data()['offer'].toString().isNotEmpty) {
          photographersDataOffer.add(PhotographerModel.fromJson(element.data()));
        }
        print(element.data()['name']);
      });
    });

    //SortLike
    for(int i=0;i<photographersData.length-1;i++)
      {
        int max = i;
        for (int j = i+1; j < photographersData.length; j++)
          {
            if(photographersData[j].like! < photographersData[max].like!) {
              max = j;
            }
            PhotographerModel temp =photographersData[max];
            photographersData[max] = photographersData[i];
            photographersData[i] = temp;
          }
      }

    for(int i=photographersData.length-1;i>=0;i--)
      {
        photographersDataSortLike.add(photographersData[i]);
      }
    notifyListeners();
    return 'success';
  }

  List<PhotographerModel> search =[];
  Future getSearch(String input) async {
    search =[];
    photographersData.forEach((element) {
      if(element.name!.toLowerCase().contains(input.toLowerCase()))
        {
          if(input.isNotEmpty)
            search.add(element);
        }
    });

    print(photographersData);
    print(search);
  }

  Future<String> updatePhotographers({
    required PhotographerModel modelPhotographer,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('photographers').doc(modelPhotographer.photographerId).set(modelPhotographer.toMap());
      notifyListeners();
      await getPhotographersData();
      notifyListeners();
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }


  removeAppointment({
    required String appointmentTime,
    required PhotographerModel model,
}) async {
    model.freeTimes!.remove(appointmentTime);
    await updatePhotographers(modelPhotographer: model);
    notifyListeners();

    List<Meeting>meetings=[];
    model.freeTimes!.remove(appointmentTime);
    meetings=(model.freeTimes!).map((e) => Meeting.fromString(e)).toList();
    await updateFreeTimesPhotographer(
      model: model,
      freeTimes: meetings.map((e) => e.toString()).toList(),
    );
    notifyListeners();

  }

  Future<String> updateFreeTimesPhotographer({
    required List<String> freeTimes,
    required PhotographerModel model,
  }) async {
    try {
      print(freeTimes[0]);
      model.freeTimes=freeTimes;
      await FirebaseFirestore.instance.collection('photographers').doc(model.photographerId).set(model.toMap());
      await updatePhotographers(modelPhotographer: model);
      notifyListeners();
      print('hi2');
      return 'success';
    } catch (e) {
      print(e.toString());
      print('hi');
      return e.toString();
    }
  }


  void changeBottomIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }





}

