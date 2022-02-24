import 'package:flutter/material.dart';

class ProfilePhotographerVisitorProvider with ChangeNotifier{

 bool isFavorite = false;

 void changeFavorite(){
   isFavorite = !isFavorite;
   notifyListeners();
 }

}