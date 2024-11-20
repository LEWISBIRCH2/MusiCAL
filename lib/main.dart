import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musical/pages/spotify_auth_page.dart';
import 'package:musical/services/spotify_service.dart';
import 'package:provider/provider.dart';
import 'package:musical/firebase_options.dart';
import 'themes/theme_provider.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

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
    return MaterialApp(
        home: MyHomePage(),
        title: 'MusiCAL',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1F2421)),
          useMaterial3: true,
        ));
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

  Future<void> getToken() async {
    accessToken = await SpotifySdk.getAccessToken(
        clientId: clientId,
        redirectUrl: redirectUrl,
        scope:
            "app-remote-control,user-modify-playback-state,playlist-read-private");
    setState(() {});
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
                    : ElevatedButton(onPressed: () {}, child: Text('API CALL')),
                Text(accessToken.toString()),
              ],
            )),
          )
        : SpotifyAuthPage(onCodeReceived: (code) async {
            accessToken = await service.exchangeToken(code);
          });
  }
}
