import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class PhysioCalendarPage extends StatefulWidget {
  const PhysioCalendarPage({Key? key}) : super(key: key);

  @override
  State<PhysioCalendarPage> createState() => _PhysioCalendarPageState();
}

class _PhysioCalendarPageState extends State<PhysioCalendarPage> {
  _PhysioCalendarPageState();

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.timelineDay,
    CalendarView.timelineWeek,
    CalendarView.timelineWorkWeek
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Đăng ký lịch tư vấn",
            style: TextStyle(fontSize: 23),
          ),
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
        ),
        body: Container(
            child: SfCalendar(
          // ignore: prefer_const_literals_to_create_immutables
          allowedViews: _allowedViews,
          view: CalendarView.week,
          allowDragAndDrop: true,
          firstDayOfWeek: 1,
          dragAndDropSettings: const DragAndDropSettings(
              autoNavigateDelay: Duration(seconds: 1)),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
