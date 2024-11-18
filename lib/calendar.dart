import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1f2421)),
        useMaterial3: true);

// Theme data not taking effect. Is it positioned right?

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel(
        todayBorderColor: Color.fromARGB(255, 81, 123, 98),
        todayButtonColor: Color.fromARGB(255, 81, 123, 98),
        thisMonthDayBorderColor: Color.fromARGB(255, 81, 123, 98),
        daysHaveCircularBorder: false,
      ),
    );
  }
}
