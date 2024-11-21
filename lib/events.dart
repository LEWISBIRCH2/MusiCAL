import 'package:flutter/material.dart';

class Event {
  final String name;
  final String date;
  final String location;
  final String description;
  final String ticketPrice;

  Event({
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    required this.ticketPrice,
  });
}

class EventsPage extends StatelessWidget {
  final Event event = Event(
    name: "Funky Festival",
    date: "12-12-24",
    location: "Manchester",
    description: "Description here.",
    ticketPrice: '£1',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Information'),
        backgroundColor: const Color.fromARGB(255, 94, 216, 125),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              event.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 2, 3, 2),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today,
                    color: const Color.fromARGB(255, 94, 216, 125)),
                SizedBox(width: 10),
                Text(
                  event.date,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color.fromARGB(255, 94, 216, 125),
                ),
                SizedBox(width: 10),
                Text(
                  event.location,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money,
                  color: const Color.fromARGB(255, 94, 216, 125),
                ),
                SizedBox(width: 10),
                Text(
                  event.ticketPrice,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                event.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
