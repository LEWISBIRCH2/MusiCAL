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
  String? userID;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String clientId = '809e9a055f604342a727aa3961f343d2';
  final String clientSecret = '6aa9ae2264094650a6af77b3eef14903';
  String redirectUrl = 'https://dapper-swan-46f09f.netlify.app';
  String? accessToken;
  SpotifyService service = SpotifyService();
  Artists? topArtists;
  Profile? profile;
  DatabaseReference dbref = FirebaseDatabase.instance.ref();

  Future<void> getToken() async {
    accessToken = await SpotifySdk.getAccessToken(
        clientId: clientId,
        redirectUrl: redirectUrl,
        scope: "user-top-read user-read-private user-read-email");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyAppState>();
    Future<void> getTopArtists() async {
      var response = await http.get(
        Uri.parse(
            'https://api.spotify.com/v1/me/top/artists?time_range=long_term&limit=20&offset=0'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      var profileResponse = await http.get(
        Uri.parse('https://api.spotify.com/v1/me'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      profile = profileFromJson(profileResponse.body);

      topArtists = artistsFromJson(response.body);
      final data = topArtists!.items;

      for (int i = 0; i < data.length; i++) {
        var newData = {
          'name': data[i].name,
          'genres': data[i].genres,
          'images': data[i].images,
        };

        appState.userID = profile!.email
            .replaceAll(RegExp(r'\.'), 'DOT_SIGN')
            .replaceAll(RegExp(r'\$'), 'DOLLAR_SIGN')
            .replaceAll(RegExp(r'\#'), 'HASH_SIGN')
            .replaceAll(RegExp(r'\['), 'OPENARRAY_SIGN')
            .replaceAll(RegExp(r'\]'), 'CLOSEARRAY_SIGN');

        setState(() {});

        await dbref
            .child(appState.userID!)
            .child('Top Artists')
            .push()
            .set(jsonEncode(newData));
      }
    }

    Future<void> getEvents() async {
      const apiKey = 'ET2XSAasDcZoaaBsaIQMLGSV3EuTFpE3';

      for (int i = 0; i < topArtists!.items.length; i++) {
        var artist = topArtists!.items[i].name;

        // var artistResponse = await http.get(Uri.parse(
        //     'https://app.ticketmaster.com/discovery/v2/attractions?apikey=$apiKey&keyword=$artist/&locale=*'));

        var response = await http.get(Uri.parse(
            'https://app.ticketmaster.com/discovery/v2/events.json?keyword=$artist&segmentName=music&apikey=$apiKey'));

        await dbref
            .child(appState.userID!)
            .child('Events')
            .push()
            .set(response.body);
      }
    }

    return kIsWeb
        ? Scaffold(
            appBar: AppBar(
              title: Text('Title'),
            ),
            body: Center(
                child: Column(
              children: [
                accessToken == null
                    ? ElevatedButton(
                        onPressed: () {
                          getToken();
                        },
                        child: Text('Login'))
                    : ElevatedButton(
                        onPressed: () async {
                          await getTopArtists();
                          getEvents();
                        },
                        child: Text('API CALL')),
                Text(accessToken.toString()),
                topArtists != null
                    ? Text(topArtists!.items[0].name)
                    : Text('No Artists...')
              ],
            )),
          )
        : SpotifyAuthPage(onCodeReceived: (code) async {
            accessToken = await service.exchangeToken(code);
            await getTopArtists();
            await getEvents();
          });
  }
}

// class Calendar extends StatelessWidget {
//   const Calendar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1f2421)),
//         useMaterial3: true);

// Theme data not taking effect. Is it positioned right?

// return Container(
//   margin: EdgeInsets.symmetric(horizontal: 16.0),
//   child: CalendarCarousel<Event>(
//     onDayPressed: (DateTime date, List<Event> events) {
//       this.setState(() => _currentDate = date);
//     },
//     weekendTextStyle: TextStyle(color: Colors.red,),
//     thisMonthDayBorderColor: Colors.grey,
//     customDayBuilder: (
//       bool isSelectable,
//       int index,
//       bool isSelectedDay,
//       bool isToday,
//       bool isPrevMonthDay,
//       TextStyle textStyle,
//       bool isNextMonthDay,
//       bool isThisMonthDay,
//       DateTime day,
//     ) {
//       if (day.day == 15) {
//         return Center(child: Icon(Icons.local_airport),);
//         else {
//           return null;
//         }
//       },
//       weekFormat: false,
//       markedDatesMap: _markedDateMap,
//       height: 420.0,
//       selectedDateTime: _currentDate,
//       daysHaveCircularBorder: false,

// todayBorderColor: Color.fromARGB(255, 81, 123, 98),
// todayButtonColor: Color.fromARGB(255, 81, 123, 98),
// thisMonthDayBorderColor: Color.fromARGB(255, 81, 123, 98),
//       ),
//     );
//   }
// }

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
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2024, 11, 25),
        new Event(
          date: new DateTime(2024, 11, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2024, 11, 10),
        new Event(
          date: new DateTime(2024, 11, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2024, 11, 11), [
      new Event(
        date: new DateTime(2024, 11, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2024, 11, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2024, 11, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example with custom icon
    final _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
//          weekDays: null, /// for pass null when you do not want to render weekDays
      headerText: 'Custom Header',
      weekFormat: true,
      markedDatesMap: _markedDateMap,
      height: 200.0,
      selectedDateTime: _currentDate2,
      showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
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
      markedDateMoreShowTotal:
          true, // null for not showing hidden events indicator
//          markedDateIconMargin: 9,
//          markedDateIconOffset: 3,
    );

    /// Example Calendar Carousel without header and custom prev & next button
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
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
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
              //custom icon
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarousel,
              ), // This trailing comma makes auto-formatting nicer for build methods.
              //custom icon without header
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
