
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class ResPons extends StatefulWidget {

  // var timeController = TextEditingController();
  // var dateController = TextEditingController();
  //
  // DateTime dataTime = DateTime.now();
  // String date='';
  @override
  State<ResPons> createState() => _ResPonsState();
}

class _ResPonsState extends State<ResPons> {


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  // send(){
  //   if(formKey.currentState!.validate()) {
  //     print('valid');
  //   } else{
  //     print('not valid');
  //   }
  //   print('ffff');
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:Center(
            child:GestureDetector(
      onTap: (){},
      child: Stack(
        alignment: Alignment.center,
        children: [
          //Icon(Icons.linked_camera, color: mainColor, size: 23,),
          CircleAvatar(
            radius: responsivizer(context, 11, 14, 16, 18),
            backgroundColor: mainColor,
          ),
          Icon(Icons.linked_camera, color: Colors.white, size: responsivizer(context, 15, 20, 23, 28),
          )
        ],
      ),
    ),
          )
        ),
      ),

    );
  }
}


// Map<String,List<dynamic>>time= {
//   '21/11/2021': ['01:00','02:00','04:00','06:00'],
//   '22/11/2021': ['03:00','05:00','07:00','09:00'],
//   '23/11/2021': ['12:00','04:00','06:00','010:00'],
// };
// List<String>list=['21/11/2021','22/11/2021','23/11/2021'];
// List<Meeting> _getDataSource() {
//   final List<Meeting> meetings = <Meeting>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//   DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));
//   meetings.add(Meeting(
//       'Conference', startTime, endTime, const Color(0xFF0F8644), false));
//   return meetings;
// }
// class MeetingDataSource extends CalendarDataSource {
//   /// Creates a meeting data source, which used to set the appointment
//   /// collection to the calendar
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return _getMeetingData(index).from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return _getMeetingData(index).to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return _getMeetingData(index).eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return _getMeetingData(index).background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return _getMeetingData(index).isAllDay;
//   }
//
//   Meeting _getMeetingData(int index) {
//     final dynamic meeting = appointments![index];
//     late final Meeting meetingData;
//     if (meeting is Meeting) {
//       meetingData = meeting;
//     }
//
//     return meetingData;
//   }
// }
//
// /// Custom business object class which contains properties to hold the detailed
// /// information about the event data which will be rendered in calendar.
// class Meeting {
//   /// Creates a meeting class with required details.
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   /// Event name which is equivalent to subject property of [Appointment].
//   String eventName;
//
//   /// From which is equivalent to start time property of [Appointment].
//   DateTime from;
//
//   /// To which is equivalent to end time property of [Appointment].
//   DateTime to;
//
//   /// Background which is equivalent to color property of [Appointment].
//   Color background;
//
//   /// IsAllDay which is equivalent to isAllDay property of [Appointment].
//   bool isAllDay;
// }






// Container(
//   height: 100,
//   width: 250,
//   child: defaultFormField(
//       controller: timeController,
//       label: 'Task time',
//       prefix: Icons.watch_later_outlined,
//       type: TextInputType.datetime,
//       onTap: () {
//
//       },
//       validate: (String? value) {
//         if (value==null || value.isEmpty) {
//           return "time must not be empty";
//         }
//
//       },
//       text: 'Time'
//   ),
// ),
// Container(
//   width: 250,
//   height: 100,
//   child: defaultFormField(
//       controller: dateController,
//       label: 'Task date',
//       prefix: Icons.calendar_today,
//       type: TextInputType.datetime,
//       onTap: () {
//         showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime.now(),
//           lastDate: DateTime.parse('2021-12-04'),
//         ).then((value) {
//
//           return dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(value!).toString();
//
//           // print(DateFormat.yMMMd().format(value));
//         });
//       },
//       validate: (String? value) {
//         if (value==null || value.isEmpty) {
//           return "date must not be empty";
//         }
//
//
//       },
//       text: 'date'),
// ),
// SizedBox(
//   height: 10,
// ),
// Container(
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(20),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black26,
//         blurRadius: 6,
//         offset: Offset(0, 5),
//       ),
//     ],
//   ),
//   height: 55,
//
//   child: CupertinoDatePicker(
//
//       use24hFormat: true,
//       initialDateTime: DateTime.now(),
//       mode: CupertinoDatePickerMode.dateAndTime,
//       onDateTimeChanged: (value) {
//         dataTime = value;
//       },
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.only(right: 15) ,
//   child: Container(
//     height: 20,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(20)),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black26,
//           blurRadius: 6,
//           offset: Offset(0, 5),
//         ),
//       ],
//     ),
//     child: TextButton(
//       child: Text('Done',style: TextStyle(color: mainColor,fontSize: 13),),
//       onPressed: (){
//         date= '${dataTime.year}-'+'${dataTime.month}-'+'${dataTime.day} '+'${dataTime.hour}:'+'${dataTime.minute}';
//         print(date);
//       },
//     ),
//   ),
// ),
// Column(
//   crossAxisAlignment: CrossAxisAlignment.end,
//   children: [
//     Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 6,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       height: 67,
//       child: CupertinoDatePicker(
//
//         use24hFormat: true,
//         initialDateTime: DateTime.now(),
//         mode: CupertinoDatePickerMode.dateAndTime,
//         onDateTimeChanged: (value) {
//           dataTime = value;
//         },
//       ),
//     ),
//     Padding(
//       padding: const EdgeInsets.only(right: 10,top: 10),
//       child: Container(
//         height: 30,
//         decoration: BoxDecoration(
//           color: mainColor,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 6,
//               offset: Offset(0, 5),
//             ),
//           ],
//         ),
//         child: TextButton(
//           child: Text('Done',style: TextStyle(color:Colors.white,fontSize: 13),),
//           onPressed: (){
//             date= '${dataTime.year}-'+'${dataTime.month}-'+'${dataTime.day} '+'${dataTime.hour}:'+'${dataTime.minute}';
//             print(date);
//           },
//         ),
//       ),
//     ),
//   ],
// ),

// Container(
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(20),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black26,
//         blurRadius: 6,
//         offset: Offset(0, 5),
//       ),
//     ],
//   ),
//   height: 60,
//   child: Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: CupertinoTheme(
//       data:CupertinoThemeData(
//           textTheme: CupertinoTextThemeData(
//             //  pickerTextStyle: TextStyle(color: Colors.blue, fontSize: 12),
//             dateTimePickerTextStyle: TextStyle(color: Colors.black54,fontSize: 24),
//           )
//       ),
//       child:  CupertinoDatePicker(
//         backgroundColor: Colors.white,
//         use24hFormat: true,
//         initialDateTime: DateTime.now(),
//         mode: CupertinoDatePickerMode.dateAndTime,
//         onDateTimeChanged: (value) {
//           dataTime = value;
//         },
//       ),
//     ),
//   ),
// ),