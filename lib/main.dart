import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musical/models/Artists-model.dart';
import 'package:musical/pages/spotify_auth_page.dart';
import 'package:musical/services/spotify_service.dart';
import 'package:provider/provider.dart';
import 'package:musical/firebase_options.dart';
import 'themes/theme_provider.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:http/http.dart' as http;

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      home: Navigation(),
      title: 'MusiCAL',
      theme: themeProvider.themeData,
    );
  }
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

  Future<void> getToken() async {
    accessToken = await SpotifySdk.getAccessToken(
        clientId: clientId, redirectUrl: redirectUrl, scope: "user-top-read");
    setState(() {});
  }

  Future<void> getTopArtists() async {
    var response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/me/top/artists?time_range=long_term&limit=20&offset=0'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final Item = jsonDecode(response.body) as Map<String, dynamic>;

    print(Item['items'][1][
        'name']); // Declared response [.items][index][subclass?] // HOW TO NAVIGATE THIS STUPID LANGUAGE

    if (mounted) {
      //UNSURE WHAT 'MOUNTED' DOES, BUT PREVENTED (NON-FATAL)ERROR MESSAGES
      setState(() {
        topArtists = artistsFromJson(response.body);
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {
                          getTopArtists();
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
          });
  }
}
