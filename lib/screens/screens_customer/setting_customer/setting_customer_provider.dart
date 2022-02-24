import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lensme/models/appointment_model.dart';
import 'package:lensme/models/customer_model.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:lensme/shared/constants.dart';

class SettingCustomerProvider with ChangeNotifier{


  CustomerModel? customerModel;

  Future getCustomerData() async {

      final data = await FirebaseFirestore.instance.collection('customers').doc(Id).get();
      notifyListeners();
      customerModel = CustomerModel.fromJson(data.data()! );
      notifyListeners();
      return 'success';
  }

  bool isPageLoading = false;
  Future<String> updateCustomer({
    required String name,
    required String phone,
    List<String>? favorites ,
    Map<String,dynamic>? rate,
  }) async {
    try {
      if (customerModel == null) throw Exception('userModel cannot be null');
      isPageLoading = true;
      notifyListeners();
      CustomerModel modelCustomer = CustomerModel(
        name: name,
        email: customerModel!.email,
        phone: phone,
        password: customerModel!.password,
        customerId:Id,
        favorites:favorites??customerModel!.favorites,
        rate: rate??customerModel!.rate ,
        isPhotographer: false,
      );
      await FirebaseFirestore.instance.collection('customers').doc(Id).update(modelCustomer.toMap());
      await getCustomerData();
      notifyListeners();
      isPageLoading = false;
      notifyListeners();
      return 'success';
    } catch (e) {
      isPageLoading = false;
      notifyListeners();
      return e.toString();
    }
  }


  late List<String> favorites= customerModel!.favorites!;

  List<PhotographerModel> favoritesModel =[];

  Future<void> getFavorite({
  required List<PhotographerModel> allPhotographers,
  }) async {
    favoritesModel =[];
    allPhotographers.forEach((model) {
      favorites.forEach((element) {
       // if(!favoritesModel.contains(model))
        if(model.photographerId == element) {
          favoritesModel.add(model);
        }
      });
    });
    notifyListeners();
  }

  Future addFavorite({
    required String id,
    required List<PhotographerModel> allPhotographers,
  }) async {
    if(!favorites.contains(id)) {
      favorites.add(id);
    }else{
      favorites.remove(id);
    }
    notifyListeners();
    await updateCustomer(
      name: customerModel!.name!,
      phone: customerModel!.phone!,
      favorites: favorites,
    );
    notifyListeners();
   await getFavorite(
      allPhotographers: allPhotographers,
    );
    notifyListeners();
  }

  bool isFavorite({
    required String id,
  }){
    return favorites.contains(id);
  }





  late Map<String,dynamic> rates= customerModel!.rate!;


  String result='';
  Future<String> addRate({
    required String id,
    required bool rate,
  }) async {
  try {
    if (!rates.containsKey(id)) {
      rates.addAll({ id: rate});
      print(rates);
      print('//////1//////');
      result='add';
    } else if (rates[id] == rate) {
      rates.remove(id);
      print(rates);
      print('//////2//////');
      result='remove';
    } else if (rates[id] != rate) {
      //rates.remove(id);
      rates.addAll({ id: rate});
      print(rates);
      print('//////3//////');
      result='add+remove';
    }
    notifyListeners();
    await updateCustomer(
      name: customerModel!.name!,
      phone: customerModel!.phone!,
      rate: rates,
    );
    notifyListeners();
    getCustomerData();
    notifyListeners();
    return result;
  }catch(e){
    return e.toString();
  }
  }


  bool doneAppointment =false;
  appointment({
    required String city,
    required String location,
    required String shootingType,
    required String appointmentTime,
    required String price,
    required String offer,
    required String photographerId,
    required String photographerName,
    required String photographerPhone,
  }) async {
    try {
      doneAppointment = true;
      if(city.isEmpty || location.isEmpty || shootingType.isEmpty || appointmentTime.isEmpty)
        {
          doneAppointment = false;
          return 'Enter the complete information';
        }else {
        AppointmentModel appointmentModel = AppointmentModel(
          customerName: customerModel!.name,
          photographerName:photographerName ,
          customerPhone: customerModel!.phone,
          photographerPhone: photographerPhone,
          city: city,
          location: location,
          shootingType: shootingType,
          appointmentTime: appointmentTime,
          price: price,
          offer: offer,
          photographerId: photographerId,
          customerId: customerModel!.customerId,
        );
        notifyListeners();
        doneAppointment = true;
        await FirebaseFirestore.instance.collection('appointments').doc().set(
            appointmentModel.toMap());
        notifyListeners();
        await FirebaseFirestore.instance.collection('photographers').doc(
            photographerId).set(appointmentModel.toMap());
        notifyListeners();
        doneAppointment =false;
        return 'success';
      }
    }catch (e) {
      print('f1');
      doneAppointment=false;
      print(e.toString());
      return 'error';
    }
  }

  late AppointmentModel appointmentModel;
  List<AppointmentModel> CustomerAppointments=[];
  customerAppointments({
    required String customerId,
  }) async {
    CustomerAppointments = [];
   try {
     await FirebaseFirestore.instance.collection('appointments').get().then((
         value) {
       value.docs.forEach((element) {
         if (element.data()['customerId'] == customerId) {
           CustomerAppointments.add(AppointmentModel.fromJson(element.data()));
           print(element.data()['appointmentTime']);
         }
       });
     });
     CustomerAppointments.sort((a, b) =>
         a.appointmentTime!.compareTo(b.appointmentTime!));
     notifyListeners();
     print('alhamad');
   }catch(e){
     print(e.toString());
     print('mshaaaaaan');
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