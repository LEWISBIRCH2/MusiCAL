import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/marked_date.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'main.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime(2024, 11, 3);
  DateTime _currentDate2 = DateTime(2024, 11, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2024, 11, 3));
  DateTime _targetDateTime = DateTime(2024, 11, 3);
  

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border:
            Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2.0)),
    child: new Icon(
      Icons.music_note,
      color: const Color.fromARGB(255, 0, 156, 70),
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2024, 11, 10): [
        ///////////////// ARRAY OF EVENTS TO ADD

        new Event(
          date: new DateTime(2024, 20, 10),
          title: 'Arctic Monkeys',
          description: 'Punk', // COULD BE GENRE
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2024, 2, 10),
          title: 'Vince Staples',
          icon: _eventIcon,
        ),
      ],
    },
  ); /////////////////////////// END OF ARRAY

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2024, 11, 25),
        new Event(
          date: new DateTime(2024, 11, 25),
          title: 'Elvis (is dead)',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2024, 11, 21),
        new Event(
          date: new DateTime(2024, 20, 11),
          title: 'Maximo Park',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2024, 2, 11), [
      // Adds all events to "ADD ALL" date provided?
      new Event(
        date: new DateTime(2024, 20, 11),
        title: 'Arctic Monkeys',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2024, 11, 11),
        title: 'Vince Staples',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      markedDateShowIcon: true,
      showIconBehindDayText: false,
      markedDateIconMaxShown: 1,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      markedDateMoreShowTotal: true,

      todayBorderColor: Colors.green,
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,

      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder: CircleBorder(
          side: BorderSide(
              color: const Color.fromARGB(1, 215, 76, 60))), //#d74c3c
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),

      todayButtonColor: const Color.fromARGB(255, 233, 255, 227),
      selectedDayTextStyle: TextStyle(
        color: const Color.fromARGB(255, 55, 255, 0),
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),

      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayPressed: (date, events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
//print(events[0].title);
print(_markedDateMap.events.entries);
   
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    return new Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 30.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: new Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  _currentMonth,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34.0,
                  ),
                )),
                TextButton(
                  child: Text('PREV'),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month - 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                ),
                TextButton(
                  child: Text('NEXT'),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month + 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child:
                    _calendarCarouselNoHeader, // THIS IS THE DATES / NUMBERS BELOW DATE
              ),
              Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  alignment: Alignment.topCenter,
                  child: Text('Selected Date: $_currentDate2')),
              Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Artist(s) Playing: $_markedDateMap',
                  ))
            ],
          ) //
        ],
      ),
    ));
  }
}
