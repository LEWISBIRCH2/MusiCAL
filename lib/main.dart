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
      final DataSnapshot snapshot = await dbref.limitToLast(1).get();
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
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2024, 11, 10): [
        new Event(
          date: new DateTime(2024, 11, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2024, 11, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2024, 11, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyAppState>();

    final _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      headerText: 'Custom Header',
      weekFormat: true,
      markedDatesMap: _markedDateMap,
      height: 200.0,
      selectedDateTime: _currentDate2,
      showIconBehindDayText: true,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      markedDateIconBuilder: (event) {
        return event.icon ?? Icon(Icons.help_outline);
      },
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.green,
      markedDateMoreShowTotal: true,
    );

    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
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
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Your Calendar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarousel,
              ),
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
                        fontSize: 24.0,
                      ),
                    )),
                    TextButton(
                      child: Text('PREV'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    TextButton(
                      child: Text('NEXT'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ), //
            ],
          ),
        ));
  }
}
