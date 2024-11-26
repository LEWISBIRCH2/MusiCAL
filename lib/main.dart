import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:musical/models/Artists-model.dart';
import 'package:musical/models/Events-model.dart';
import 'package:musical/models/Festival-model.dart';
import 'package:musical/models/Profile-model.dart';
import 'package:musical/pages/spotify_auth_page.dart';
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
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'loading.dart';

// THE FORBIDDEN RUN COMMAND:
// flutter run --web-port=50511 --host-vmservice-port=50511 -d chrome --web-browser-flag "--disable-web-security"

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
  Artists? topArtists;
  Profile? profile;
  DatabaseReference dbref = FirebaseDatabase.instance.ref();
  String? userID;
  List<UserEvent> events = [];
  List<String>? eventsStrings;
  UserEvent? selectedEvent;
  List<String> festNames = [];
  List<Festival> userFestivals = [];
  Iterable<UserEvent> calEvents = [];
  bool isLoading = false;

  Future<void> getToken() async {
    accessToken = await SpotifySdk.getAccessToken(
        clientId: clientId,
        redirectUrl: redirectUrl,
        scope: "user-top-read user-read-private user-read-email");

    notifyListeners();
  }

  Future<String?> exchangeToken(String code) async {
    isLoading = true;
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUrl,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      print('Error exchanging token: ${response.body}');
      return null;
    }
  }

  Future<void> getTopArtists() async {
    var response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/me/top/artists?time_range=medium_term&limit=30&offset=0'),
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
    const apiKey = 'oQwxcMmwTA9qT7sBrpax4NH0nzTiuWSw';

    for (int i = 0; i < topArtists!.items.length; i++) {
      var artist = topArtists!.items[i].name;

      var response = await http.get(Uri.parse(
          'https://app.ticketmaster.com/discovery/v2/events.json?keyword=$artist&segmentName=music&countryCode=GB&apikey=$apiKey'));

      dbref.child(userID!).child('Events').child('Event $i').push();
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
    isLoading = false;
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
        String? eventImage;
        String? eventVenue;

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

        eventImage = eventsStrings[i]
            .split("images")[1]
            .split('url":"')[1]
            .split('","width')[0];

        if (eventsStrings[i].contains('{"venues":[{"name":"')) {
          eventVenue =
              eventsStrings[i].split('{"venues":[{"name":"')[1].split('","')[0];
        } else {
          eventVenue = 'not found';
        }

        events.add(UserEvent(
            eventName: eventName,
            eventID: eventID,
            eventDate: eventDate,
            eventStartTime: eventStartTime,
            eventPostcode: eventPostcode,
            eventTicketUrl: eventTicketUrl,
            eventImage: eventImage,
            eventVenue: eventVenue));
      }
    }
    notifyListeners();
  }

  Future<void> getFestivals() async {
    const apiKey = 'oQwxcMmwTA9qT7sBrpax4NH0nzTiuWSw';

    var response = await http.get(Uri.parse(
        'https://app.ticketmaster.com/discovery/v2/events.json?keyword=festival&segmentName=music&countryCode=GB&size=200&apikey=$apiKey'));

    List<String> festivals = response.body.split(']}},{"name":"');
    festivals.removeLast();

    for (int i = 0; i < festivals.length; i++) {
      String? name;
      String? location;
      List<String>? artists = [];
      String? date;
      String? url;

      if (i == 0) {
        name = festivals[i]
            .split('{"_embedded":{"events":[{"name":"')[1]
            .split('","')[0];
      } else {
        name = festivals[i].split('","')[0];
      }

      location = festivals[i].split('venues":[{"name":"')[1].split('","')[0];

      date = festivals[i].split('"localDate":"')[1].split('","')[0];

      url = festivals[i].split('"url":"')[1].split('","')[0];

      if (festivals[i].contains('],"attractions":')) {
        List<String> artistStrings =
            festivals[i].split('],"attractions":')[1].split('{"name":"');
        artistStrings.removeAt(0);

        for (int j = 0; j < artistStrings.length; j++) {
          artists.add(artistStrings[j].split('","')[0]);
        }

        if (artists.length >= 1) {
          festNames.add(name);
          dbref.child('Festivals').child('$name').push();
          await dbref
              .child('Festivals')
              .child('$name')
              .set(festivalToJson(Festival(
                name: name,
                location: location,
                artists: artists,
                date: date,
                url: url,
                festRec: 0,
              )));
        }
      }
    }
    notifyListeners();
  }

  Future<void> getUserFestivals() async {
    for (int i = 0; i < festNames.length; i++) {
      await dbref.child('Festivals').child(festNames[i]).get().then((data) {
        Festival f = festivalFromJson(data.value.toString());
        for (int j = 0; j < topArtists!.items.length; j++) {
          if (f.artists!.contains(topArtists!.items[j].name)) {
            f.festRec++;
          }
        }
        userFestivals.add(f);
      });
    }
    userFestivals.sort((f1, f2) => f1.festRec.compareTo(f2.festRec));
    for (int i = 0; i < userFestivals.length; i++) {
      if (userFestivals[i].festRec > 0) {
        print(festivalToJson(userFestivals[i]));
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
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appState.accessToken == null
                    ? Column(
                        children: [
                          Image.asset('assets/images/musiCAL_LOGO.png'),
                          ElevatedButton(
                              onPressed: () {
                                appState.getToken();
                              },
                              child: Text('LOGIN')),
                        ],
                      )
                    : Column(
                        children: [
                          Image.asset('assets/images/musiCAL_LOGO.png'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await appState.getTopArtists();
                                  print('1');
                                  await appState.getEvents();
                                  print('2');
                                  await appState.getUsersEvents();
                                  print('3');
                                  await appState.getFestivals();
                                  print('4');
                                  await appState.getUserFestivals();
                                  print('5');
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Navigation()));
                                },
                                child: Text('OPEN CALENDAR')),
                          ),
                        ],
                      ),
              ],
            )),
          )
        : SpotifyAuthPage(onCodeReceived: (code) async {
            appState.accessToken = await appState.exchangeToken(code);
            await appState.getTopArtists();
            await appState.getEvents();
            await appState.getUsersEvents();
            await appState.getFestivals();
            await appState.getUserFestivals();
          });
  }
}

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final DateTime _currentDate = DateTime(2024, 11, 3);
  DateTime _currentDate2 = DateTime(2024, 11, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2024, 11, 3));
  DateTime _targetDateTime = DateTime(2024, 11, 3);

  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border:
            Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2.0)),
    child: Icon(
      Icons.music_note,
      color: const Color.fromARGB(255, 0, 156, 70),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyAppState>();

    EventList<Event> markedDateMap = EventList<Event>(
      events: {},
    );

    for (int i = 0; i < appState.events.length; i++) {
      if (appState.events[i].eventDate != 'not found') {
        List dateArray = appState.events[i].eventDate!.split('-');
        int year = int.parse(dateArray[0]);
        int month = int.parse(dateArray[1]);
        int day = int.parse(dateArray[2]);

        markedDateMap.add(
            DateTime(year, month, day),
            Event(
              date: DateTime(year, month, day),
              title: appState.events[i].eventName,
              icon: _eventIcon,
            ));
      }
    }

    final calendarCarouselNoHeader = CalendarCarousel<Event>(
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
      markedDatesMap: markedDateMap,
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
      prevDaysTextStyle: TextStyle(fontSize: 16, color: Colors.black),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),

      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayPressed: (date, events) {
        setState(() {
          _currentDate2 = date;
          appState.calEvents = appState.events.where((e) {
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
            return d == date;
          });
        });
      },
      onDayLongPressed: (DateTime date) {},
    );
    return appState.isLoading
        ? PianoLoading()
        : Scaffold(
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
                  child: Row(
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
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month - 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      ),
                      TextButton(
                        child: Text('NEXT'),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month + 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.39,
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: calendarCarouselNoHeader,
                    ),
                    Container(
                      color: Colors.black,
                      height: 2,
                    ),
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < appState.calEvents.length; i++)
                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        appState.selectedEvent =
                                            appState.calEvents.elementAt(i);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EventsPage()));
                                      },
                                      child: Text(appState.calEvents
                                          .elementAt(i)
                                          .eventName!)),
                                ],
                              ),
                          ],
                        ),
                      ),
                    )
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
  final String? image;
  final String? venue;

  EventPageEvent({
    this.name,
    this.date,
    this.location,
    this.description,
    this.ticketUrl,
    this.image,
    this.venue,
  });
}

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});
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
      image: Uevent.eventImage,
      venue: Uevent.eventVenue,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(event.image!,
                      width: double.infinity, height: 200, fit: BoxFit.cover),
                  SizedBox(height: 50),
                  Text(event.name!,
                      style: Theme.of(context).textTheme.headlineLarge),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today,
                          color: const Color.fromARGB(255, 94, 216, 125)),
                      SizedBox(width: 10),
                      Text(
                        event.date!,
                        style: Theme.of(context).textTheme.bodyMedium,
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
                      SizedBox(width: 10, height: 10),
                      Text(
                        event.venue!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: 10, height: 10),
                      Text(event.location!)
                    ],
                  ),
                  SizedBox(height: 20, width: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: const Color.fromARGB(255, 94, 216, 125),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          final Uri url = Uri.parse(event.ticketUrl!);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        child: Text(
                          'Buy tickets',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
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

class Festical extends StatelessWidget {
  const Festical({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyAppState>();

    Artists? festArtists = appState.topArtists;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.filter_1_rounded),
                ),
                Tab(
                  icon: Icon(Icons.filter_2_rounded),
                ),
                Tab(
                  icon: Icon(Icons.filter_3_rounded),
                )
              ],
            ),
            title: const Text('Your Festical'),
          ),
          body: TabBarView(children: [
            Center(
              child: Stack(
                children: [
                  Image.asset('assets/images/EmptyLineUp.jpg'),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.5, -0.5),
                          child: Text(
                            festArtists!.items.elementAt(0).name,
                            style: GoogleFonts.getFont('Jura'),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.7, -0.21),
                          child: Text(
                            festArtists.items.elementAt(1).name,
                            style: GoogleFonts.getFont('Jura'),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.5, 0.08),
                          child: Text(
                            festArtists.items.elementAt(2).name,
                            style: GoogleFonts.getFont('Jura'),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.85, -0.4),
                          child: Text(
                            festArtists.items.elementAt(3).name,
                            style: GoogleFonts.getFont('Jura'),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.27, -0.4),
                          child: Text(
                            festArtists.items.elementAt(4).name,
                            style: GoogleFonts.getFont('Jura'),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.33, -0.4),
                          child: AutoSizeText(
                            festArtists.items.elementAt(5).name,
                            style: TextStyle(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.92, -0.4),
                          child: Text(
                            festArtists.items.elementAt(6).name,
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.87, -0.31),
                          child: Text(
                            festArtists.items.elementAt(7).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.41, -0.31),
                          child: Text(
                            festArtists.items.elementAt(8).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.02, -0.31),
                          child: Text(
                            festArtists.items.elementAt(9).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.45, -0.31),
                          child: Text(
                            festArtists.items.elementAt(10).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.89, -0.31),
                          child: Text(
                            festArtists.items.elementAt(11).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.85, -0.11),
                          child: Text(
                            festArtists.items.elementAt(12).name,
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.27, -0.11),
                          child: Text(
                            festArtists.items.elementAt(13).name,
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.33, -0.11),
                          child: Text(
                            festArtists.items.elementAt(14).name,
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.92, -0.11),
                          child: Text(
                            festArtists.items.elementAt(15).name,
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.87, -0.02),
                          child: Text(
                            festArtists.items.elementAt(16).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.41, -0.02),
                          child: Text(
                            festArtists.items.elementAt(17).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.02, -0.02),
                          child: Text(
                            festArtists.items.elementAt(18).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.45, -0.02),
                          child: Text(
                            festArtists.items.elementAt(19).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.89, -0.02),
                          child: Text(
                            festArtists.items.elementAt(20).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.85, 0.18),
                          child: Text(
                            festArtists.items.elementAt(21).name,
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.27, 0.18),
                          child: Text(
                            festArtists.items.elementAt(22).name,
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.33, 0.18),
                          child: Text(
                            festArtists.items.elementAt(23).name,
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.92, 0.18),
                          child: Text(
                            festArtists.items.elementAt(24).name,
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.87, 0.27),
                          child: Text(
                            festArtists.items.elementAt(25).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.41, 0.27),
                          child: Text(
                            festArtists.items.elementAt(26).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.02, 0.27),
                          child: Text(
                            festArtists.items.elementAt(27).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.45, 0.27),
                          child: Text(
                            festArtists.items.elementAt(28).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.89, 0.27),
                          child: Text(
                            festArtists.items.elementAt(29).name,
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          )))
                ],
              ),
            ),
            Center(
                child: Stack(children: [
              Image.asset('assets/images/glastonbury_poster_template.jpg'),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.7, -0.15),
                      child: Text(
                        festArtists.items.elementAt(0).name,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0, -0.27),
                      child: Text(
                        festArtists.items.elementAt(1).name,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.7, -0.15),
                      child: Text(
                        festArtists.items.elementAt(2).name,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.85, 0),
                      child: Text(
                        festArtists.items.elementAt(3).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.3, 0),
                      child: Text(
                        festArtists.items.elementAt(4).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.3, 0),
                      child: Text(
                        festArtists.items.elementAt(5).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0),
                      child: Text(
                        festArtists.items.elementAt(6).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.85, 0.12),
                      child: Text(
                        festArtists.items.elementAt(7).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.3, 0.12),
                      child: Text(
                        festArtists.items.elementAt(8).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.3, 0.12),
                      child: Text(
                        festArtists.items.elementAt(9).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.12),
                      child: Text(
                        festArtists.items.elementAt(10).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.85, 0.25),
                      child: Text(
                        festArtists.items.elementAt(11).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.3, 0.25),
                      child: Text(
                        festArtists.items.elementAt(12).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.3, 0.25),
                      child: Text(
                        festArtists.items.elementAt(13).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.25),
                      child: Text(
                        festArtists.items.elementAt(14).name,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.86, 0.4),
                      child: Text(
                        festArtists.items.elementAt(15).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.45, 0.4),
                      child: Text(
                        festArtists.items.elementAt(16).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.05, 0.4),
                      child: Text(
                        festArtists.items.elementAt(17).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, 0.4),
                      child: Text(
                        festArtists.items.elementAt(18).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.4),
                      child: Text(
                        festArtists.items.elementAt(19).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.86, 0.55),
                      child: Text(
                        festArtists.items.elementAt(20).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.45, 0.55),
                      child: Text(
                        festArtists.items.elementAt(21).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.05, 0.55),
                      child: Text(
                        festArtists.items.elementAt(22).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, 0.55),
                      child: Text(
                        festArtists.items.elementAt(23).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.55),
                      child: Text(
                        festArtists.items.elementAt(24).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.86, 0.7),
                      child: Text(
                        festArtists.items.elementAt(25).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.45, 0.7),
                      child: Text(
                        festArtists.items.elementAt(26).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.05, 0.7),
                      child: Text(
                        festArtists.items.elementAt(27).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, 0.7),
                      child: Text(
                        festArtists.items.elementAt(28).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.7),
                      child: Text(
                        festArtists.items.elementAt(29).name,
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
            ])),
            Center(
                child: Stack(children: [
              Image.asset('assets/images/leeds_final.jpg'),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.5, -0.8),
                      child: Text(
                        festArtists.items.elementAt(0).name,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.2, -0.95),
                      child: Text(
                        festArtists.items.elementAt(1).name,
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, -0.8),
                      child: Text(
                        festArtists.items.elementAt(2).name,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.57, -0.5),
                      child: Text(
                        festArtists.items.elementAt(3).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.1, -0.5),
                      child: Text(
                        festArtists.items.elementAt(4).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, -0.5),
                      child: Text(
                        festArtists.items.elementAt(5).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, -0.5),
                      child: Text(
                        festArtists.items.elementAt(6).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.57, -0.3),
                      child: Text(
                        festArtists.items.elementAt(7).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.1, -0.3),
                      child: Text(
                        festArtists.items.elementAt(8).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, -0.3),
                      child: Text(
                        festArtists.items.elementAt(9).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, -0.3),
                      child: Text(
                        festArtists.items.elementAt(10).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.57, -0.1),
                      child: Text(
                        festArtists.items.elementAt(11).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.1, -0.1),
                      child: Text(
                        festArtists.items.elementAt(12).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, -0.1),
                      child: Text(
                        festArtists.items.elementAt(13).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, -0.1),
                      child: Text(
                        festArtists.items.elementAt(14).name,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.6, 0.1),
                      child: Text(
                        festArtists.items.elementAt(15).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.25, 0.1),
                      child: Text(
                        festArtists.items.elementAt(16).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.15, 0.1),
                      child: Text(
                        festArtists.items.elementAt(17).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.55, 0.1),
                      child: Text(
                        festArtists.items.elementAt(18).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, 0.1),
                      child: Text(
                        festArtists.items.elementAt(19).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.6, 0.3),
                      child: Text(
                        festArtists.items.elementAt(20).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.25, 0.3),
                      child: Text(
                        festArtists.items.elementAt(21).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.15, 0.3),
                      child: Text(
                        festArtists.items.elementAt(22).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.55, 0.3),
                      child: Text(
                        festArtists.items.elementAt(23).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, 0.3),
                      child: Text(
                        festArtists.items.elementAt(24).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.6, 0.5),
                      child: Text(
                        festArtists.items.elementAt(25).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.25, 0.5),
                      child: Text(
                        festArtists.items.elementAt(26).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.15, 0.5),
                      child: Text(
                        festArtists.items.elementAt(27).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.55, 0.5),
                      child: Text(
                        festArtists.items.elementAt(28).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, 0.5),
                      child: Text(
                        festArtists.items.elementAt(29).name,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
            ]))
          ]),
        ));
  }
}
