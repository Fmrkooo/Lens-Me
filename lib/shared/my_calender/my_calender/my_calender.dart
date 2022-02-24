import 'package:flutter/material.dart';
import 'package:lensme/shared/my_calender/my_calender/meeting.dart';
import 'package:lensme/shared/my_calender/my_calender/meeting_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalender extends StatelessWidget {
  final List<Meeting> meetings;
  final void Function(CalendarTapDetails) onTap;

  const MyCalender({
    Key? key,
    required this.meetings,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      dataSource: MeetingDataSource(meetings),
      onTap: (calendarTapDetails) => onTap(calendarTapDetails),
        minDate:DateTime.now(),
      maxDate: DateTime.now().add(Duration(days: 14)),
    );
  }
}
