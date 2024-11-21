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

class _MyAppState extends ChangeNotifier {}

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
  String? userID;
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

        userID = profile!.email
            .replaceAll(RegExp(r'\.'), 'DOT_SIGN')
            .replaceAll(RegExp(r'\$'), 'DOLLAR_SIGN')
            .replaceAll(RegExp(r'\#'), 'HASH_SIGN')
            .replaceAll(RegExp(r'\['), 'OPENARRAY_SIGN')
            .replaceAll(RegExp(r'\]'), 'CLOSEARRAY_SIGN');

        await dbref
            .child(userID!)
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

        await dbref.child(userID!).child('Events').push().set(response.body);
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
