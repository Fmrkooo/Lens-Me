import 'package:flutter/material.dart';

class FilteringCustomerProvider with ChangeNotifier{

  var selectedRange= RangeValues(25.0 , 75.0);

  List<String> listLocations =[
    'Ajlon', 'Amman', 'Aqaba', 'Balqa', 'Irbid', 'Jarash', 'Karak',
    'Ma\'an', 'Madaba', 'Mafraq', 'Tafeleh', 'Zarqa',
  ];

  List<String> listShootingTypes =[
    'wedding','Graduation','personal','Food','Natural','party','Tv',
    'video photography','cinematography','baby photography','MakeUp photography',
  ];

  List<String> listPracticalExperience =[
    'less than one year','One year','Two years','Three years','Four years','Five years',
    'Six years','Seven years','Eight years','Nine years','Ten years','more than Ten years',
  ];

  List<String> listTime =
  ['12:00','12:30','01:00','01:30','02:00','02:30', '03:00'];

  selectRange(RangeValues newRange)
  {
    selectedRange=newRange;
    notifyListeners();
  }

}