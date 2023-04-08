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
        // onTap: calendarTapped,
        view: CalendarView.week,
        allowDragAndDrop: true,
        firstDayOfWeek: 1,
        dragAndDropSettings:
            const DragAndDropSettings(autoNavigateDelay: Duration(seconds: 1)),
        dataSource: MeetingDataSource(getAppoinents()),
      )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
    );
  }
}

List<Appointment> getAppoinents() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 1));
  RecurrenceProperties recurrence =
      RecurrenceProperties(startDate: DateTime.now());

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Conference',
      // recurrenceRule: 'FREQ=HOUR;INTERVAL=1;COUNT=10',

      color: Colors.blue));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

String? _subjectText = '',
    _startTimeText = '',
    _endTimeText = '',
    _dateText = '',
    _timeDetails = '';
Color? _headerColor, _viewHeaderColor, _calendarColor;

// void calendarTapped(CalendarTapDetails details) {
//   if (details.targetElement == CalendarElement.appointment ||
//       details.targetElement == CalendarElement.agenda) {
//     final Appointment appointmentDetails = details.appointments![0];
//     _subjectText = appointmentDetails.subject;
//     _dateText = DateFormat('MMMM dd, yyyy')
//         .format(appointmentDetails.startTime)
//         .toString();
//     _startTimeText =
//         DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
//     _endTimeText =
//         DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
//     if (appointmentDetails.isAllDay) {
//       _timeDetails = 'All day';
//     } else {
//       _timeDetails = '$_startTimeText - $_endTimeText';
//     }
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Container(child: new Text('$_subjectText')),
//             content: Container(
//               height: 80,
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Text(
//                         '$_dateText',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Text(''),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Text(_timeDetails!,
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400, fontSize: 15)),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               new TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: new Text('close'))
//             ],
//           );
//         });
//   }
// }