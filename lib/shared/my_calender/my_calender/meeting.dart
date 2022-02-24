import 'package:flutter/material.dart';
import 'package:lensme/shared/theme/colors.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;

  @override
  bool operator ==(other) {
    return other is Meeting && from == other.from && to == other.to;
  }

  @override
  int get hashCode => from.hashCode + to.hashCode;

  @override
  toString(){

    return from.year.toString() + '/' + addZeroIfLessThanTen(from.month.toString()) + '/' + addZeroIfLessThanTen(from.day.toString()) + ' ' + addZeroIfLessThanTen(from.hour.toString()) + ':00' + " - " + addZeroIfLessThanTen(to.hour.toString()) + ':00';
  }

  static Meeting fromString(String meeting){
    DateTime from = DateTime(
      int.parse(meeting.split('/')[0]),
      int.parse(meeting.split('/')[1]),
      int.parse(meeting.split('/')[2].split(' ')[0]),
      int.parse(meeting.split(' ')[1].split('-')[0].split(':')[0]),
      //int.parse(meeting.split(' ')[2].split('-')[1].split(':')[1])
    );
    return Meeting(
      '',
      from,
      from.add(Duration(hours: 1)),
      mainColor,
      false,
    );
  }


  static String addZeroIfLessThanTen(String time){
    return (time.length == 1 ? '0' : '')+time;
  }
}

