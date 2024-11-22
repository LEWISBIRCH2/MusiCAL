import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musical/models/Artists-Ticketmaster-model.dart';
import 'package:musical/models/Artists-model.dart';
import 'package:musical/models/Events-model.dart';
import 'package:musical/models/Profile-model.dart';
import 'package:musical/pages/spotify_auth_page.dart';
import 'package:musical/services/spotify_service.dart';
import 'package:provider/provider.dart';
import 'package:musical/firebase_options.dart';
import 'themes/theme_provider.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'bottomnavbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => _MyAppState(),
      child: MaterialApp(
        home: MyHomePage(),
        //MyHomePage())
        title: 'MusiCAL',
        theme: themeProvider.themeData,
      ),
    );
  }
}

class _MyAppState extends ChangeNotifier {
  final String clientId = '809e9a055f604342a727aa3961f343d2';
  final String clientSecret = '6aa9ae2264094650a6af77b3eef14903';
  String redirectUrl = 'https://dapper-swan-46f09f.netlify.app';
  String? accessToken;
  SpotifyService service = SpotifyService();
  Artists? topArtists;
  Profile? profile;
  DatabaseReference dbref = FirebaseDatabase.instance.ref();
  String? userID;
  List<UserEvent> events = [];
  List<String>? eventsStrings;
  UserEvent? selectedEvent;

  Future<void> getToken() async {
    accessToken = await SpotifySdk.getAccessToken(
        clientId: clientId,
        redirectUrl: redirectUrl,
        scope: "user-top-read user-read-private user-read-email");

    notifyListeners();
  }

  Future<void> getTopArtists() async {
    var response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/me/top/artists?time_range=medium_term&limit=20&offset=0'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    var profileResponse = await http.get(
      Uri.parse('https://api.spotify.com/v1/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    profile = profileFromJson(profileResponse.body);

    topArtists = artistsFromJson(response.body);
    final data = topArtists!.items;

    userID = profile!.email
        .replaceAll(RegExp(r'\.'), 'DOT_SIGN')
        .replaceAll(RegExp(r'\$'), 'DOLLAR_SIGN')
        .replaceAll(RegExp(r'\#'), 'HASH_SIGN')
        .replaceAll(RegExp(r'\['), 'OPENARRAY_SIGN')
        .replaceAll(RegExp(r'\]'), 'CLOSEARRAY_SIGN');

    try {
      final DataSnapshot snapshot = await dbref.get();
      if (snapshot.value.toString().contains(userID!)) {
      } else {
        for (int i = 0; i < data.length; i++) {
          var newData = {
            'name': data[i].name,
            'genres': data[i].genres,
            'images': data[i].images,
          };
          await dbref
              .child(userID!)
              .child('Top Artists')
              .push()
              .set(jsonEncode(newData));
        }

        notifyListeners();
      }
    } catch (error) {
      print('Error');
    }
  }

  Future<void> getEvents() async {
    const apiKey = 'ET2XSAasDcZoaaBsaIQMLGSV3EuTFpE3';

    for (int i = 0; i < topArtists!.items.length; i++) {
      var artist = topArtists!.items[i].name;

      // var artistResponse = await http.get(Uri.parse(
      //     'https://app.ticketmaster.com/discovery/v2/attractions?apikey=$apiKey&keyword=$artist/&locale=*'));

      var response = await http.get(Uri.parse(
          'https://app.ticketmaster.com/discovery/v2/events.json?keyword=$artist&segmentName=music&countryCode=GB&apikey=$apiKey'));

      await dbref.child(userID!).child('Events').child('Event $i').push();
      await dbref
          .child(userID!)
          .child('Events')
          .child('Event $i')
          .set(response.body);
    }
    notifyListeners();
  }

  Future<void> getUsersEvents() async {
    for (int i = 0; i < topArtists!.items.length; i++) {
      await dbref
          .child(userID!)
          .child('Events')
          .child('Event $i')
          .get()
          .then((data) {
        sortUserEvents(data.value.toString());
      });
    }
    notifyListeners();
  }

  void sortUserEvents(String userEvent) {
    if (userEvent.startsWith('{"_embedded')) {
      String eventString = userEvent.split('{"events')[1];
      List<String>? eventsStrings = eventString.split('}},{"name"');
      for (int i = 0; i < eventsStrings.length; i++) {
        String? eventName;
        String? eventID;
        String? eventDate;
        String? eventStartTime;
        String? eventTicketUrl;
        String? eventPostcode;

        if (i == 0) {
          eventName =
              eventsStrings[i].split('","')[0].replaceFirst('":[{"name":"', '');
        } else {
          eventName = eventsStrings[i].split('","')[0].replaceFirst(':"', '');
        }

        eventID = eventsStrings[i].split(',"id":"')[1].split('","')[0];

        if (eventsStrings[i].contains('{"localDate":"')) {
          eventDate =
              eventsStrings[i].split('{"localDate":"')[1].split('","')[0];
        } else {
          eventDate = 'not found';
        }

        if (eventsStrings[i].contains('"localTime":"')) {
          eventStartTime =
              eventsStrings[i].split('"localTime":"')[1].split('","')[0];
        } else {
          eventStartTime = 'not found';
        }

        if (eventsStrings[i].contains('postalCode":"')) {
          eventPostcode =
              eventsStrings[i].split('postalCode":"')[1].split('","')[0];
        } else {
          eventPostcode = 'not found';
        }

        eventTicketUrl = eventsStrings[i].split('"url":"')[1].split('","')[0];

        events.add(UserEvent(
            eventName: eventName,
            eventID: eventID,
            eventDate: eventDate,
            eventStartTime: eventStartTime,
            eventPostcode: eventPostcode,
            eventTicketUrl: eventTicketUrl));
      }
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyAppState>();

    return kIsWeb
        ? Scaffold(
            appBar: AppBar(
              title: Text('Title'),
            ),
            body: Center(
                child: Column(
              children: [
                appState.accessToken == null
                    ? ElevatedButton(
                        onPressed: () {
                          appState.getToken();
                        },
                        child: Text('Login'))
                    : ElevatedButton(
                        onPressed: () async {
                          await appState.getTopArtists();
                          appState.getEvents();
                        },
                        child: Text('API CALL')),
                Text(appState.accessToken.toString()),
                appState.topArtists != null
                    ? Text(appState.topArtists!.items[0].name)
                    : Text('No Artists...')
              ],
            )),
          )
        : SpotifyAuthPage(onCodeReceived: (code) async {
            appState.accessToken = await appState.service.exchangeToken(code);
            await appState.getTopArtists();
            await appState.getEvents();
            await appState.getUsersEvents();
          });
  }
}

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

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyAppState>();

    EventList<Event> _markedDateMap = new EventList<Event>(
      events: {},
    );

    for (int i = 0; i < appState.events.length; i++) {
      if (appState.events[i].eventDate != 'not found') {
        List dateArray = appState.events[i].eventDate!.split('-');
        int year = int.parse(dateArray[0]);
        int month = int.parse(dateArray[1]);
        int day = int.parse(dateArray[2]);

        _markedDateMap.add(
            new DateTime(year, month, day),
            new Event(
              date: new DateTime(year, month, day),
              title: appState.events[i].eventName,
              icon: _eventIcon,
            ));
      }
    }

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
        //print(events[0].title);
        events.forEach((event) => print(event.title));
        var eventFilter = appState.events.where((e) {
          DateTime d;
          if (e.eventDate != 'not found') {
            List dateArray = e.eventDate!.split('-');
            int year = int.parse(dateArray[0]);
            int month = int.parse(dateArray[1]);
            int day = int.parse(dateArray[2]);
            d = DateTime(year, month, day);
          } else {
            d = DateTime(0, 0, 0);
          }
          return e.eventName == events[0].title && d == events[0].date;
        });
        appState.selectedEvent = eventFilter.elementAt(0);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EventsPage()));
      },
      onDayLongPressed: (DateTime date) {},
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
                    'Artist(s) Playing: ',
                  ))
            ],
          ) //
        ],
      ),
    ));
  }
}

class EventPageEvent {
  final String? name;
  final String? date;
  final String? location;
  final String? description;
  final String? ticketUrl;

  EventPageEvent({
    this.name,
    this.date,
    this.location,
    this.description,
    this.ticketUrl,
  });
}

class EventsPage extends StatefulWidget {
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyAppState>();

    UserEvent? Uevent = appState.selectedEvent;

    final EventPageEvent event = EventPageEvent(
      name: Uevent!.eventName,
      date: Uevent.eventDate,
      location: Uevent.eventPostcode,
      description: "Description here.",
      ticketUrl: Uevent.eventTicketUrl,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('EventPageEvent Information'),
        backgroundColor: const Color.fromARGB(255, 94, 216, 125),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: const Color.fromARGB(255, 94, 216, 125),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 8),
                Text(
                  'Back to calendar',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    event.name!,
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
                        event.date!,
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
                        event.location!,
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
                        event.ticketUrl!,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      event.description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
