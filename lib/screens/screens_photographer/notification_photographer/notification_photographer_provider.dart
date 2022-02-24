
import 'package:flutter/material.dart';

class NotificationPhotographerProvider with ChangeNotifier{

  List<Widget> list=[];

  getData(Widget widget){
    list.add(widget);
  }
}