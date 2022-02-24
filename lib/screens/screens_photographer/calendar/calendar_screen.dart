import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:lensme/screens/screens_photographer/setting_photographer/setting_photographer_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/shared/my_calender/my_calender/meeting.dart';
import 'package:lensme/shared/my_calender/my_calender/my_calender.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {

  final PhotographerModel model;

  const CalendarScreen(this.model) ;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {



  // @override
  // void initState() {
  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //   //Provider.of<SettingPhotographerProvider>(context, listen: false).getPhotographerData();
  //   meetings= widget.model.freeTimes!.map((e) => Meeting.fromString(e)).toList();
  //   meetings.removeWhere((element) => element.from.isBefore(DateTime.now().add(Duration(hours:1))));
  //   //Provider.of<SettingPhotographerProvider>(context, listen: false).updateFreeTimes(freeTimes: meetings.map((e) => e.toString()).toList());
  //   });
  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {


    var watch = context.watch<SettingPhotographerProvider>();
    var read = context.read<SettingPhotographerProvider>();
    var LayoutRead = context.read<LayoutProvider>();

    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColor,
            //Colors.white,
            size:responsivizer(context, 26, 28, 30, 32),
          ),
        ),
        title: Text(
          'Calendar',
          style: TextStyle(
            //color: Colors.white,
            color:mainColor,
            fontWeight: FontWeight.bold,
            fontSize: responsivizer(context, 20, 24, 28, 33),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('photographers').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
            List<DocumentSnapshot> docs=snapshot.data!.docs;
            List<Meeting>meeting = [];
            for(var doc in docs)
              {
                if(doc.id == widget.model.photographerId &&
                doc.data().toString().contains('freeTimes')
                )
                meeting=doc.get('freeTimes').map<Meeting>((e) => Meeting.fromString(e)).toList();
               // print(doc.data());
              }
            List<String>meetingList=(meeting.map((e) => e.toString()).toList());
            widget.model.freeTimes=meetingList;

            return MyCalender(
              meetings:meeting,
              onTap: (CalendarTapDetails date){

                Meeting meeting = Meeting('',date.date! , date.date!.add(const Duration(hours: 1)),mainColor,false);


                read.addTimeAppointment(freeTime:meeting.toString());
                read.changeNotFalse();
              },
            );
          },
        ),
      ),
    );
  }
}

