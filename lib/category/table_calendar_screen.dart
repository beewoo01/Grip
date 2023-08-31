import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class TableCalendarScreen extends StatelessWidget {
  const TableCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return const TableCalendarScreenSlw();
  }

}

class TableCalendarScreenSlw extends StatefulWidget {
  const TableCalendarScreenSlw({super.key});

  @override
  State createState() => _TableCalendarScreen();

}


class _TableCalendarScreen extends State<TableCalendarScreenSlw> {

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: TableCalendar(
        locale: 'ko-KR',
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        availableCalendarFormats: const {
          CalendarFormat.month: '한달'
        },
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
            Navigator.pop(context, selectedDay);
          });
        },

        selectedDayPredicate: (DateTime day) {
          return selectedDay == day;
        },
      ),
    );
  }


}