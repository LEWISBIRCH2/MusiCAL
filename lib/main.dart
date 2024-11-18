import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:oauth2_client/spotify_oauth2_client.dart';
// import 'package:oauth2_client/access_token_response.dart';
import 'settings.dart';
import 'package:musiCAL/pages/spotify_auth_page.dart';
import 'defaulttab.dart';
// import 'package:http/http.dart' as http;
import 'package:musiCAL/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // var Access_Token;
  // var Refresh_Token;

  // Future<void> remoteService() async {
  //   final String clientId = '809e9a055f604342a727aa3961f343d2';
  //   final String clientSecret = '6aa9ae2264094650a6af77b3eef14903';
  //   AccessTokenResponse? accessToken;
  //   SpotifyOAuth2Client client = SpotifyOAuth2Client(
  //     customUriScheme: 'musiCAL.app',
  //     //Must correspond to the AndroidManifest's "android:scheme" attribute
  //     redirectUri:
  //         'musiCAL.app://callback', //Can be any URI, but the scheme part must correspond to the customeUriScheme
  //   );
  //   var authResp =
  //       await client.requestAuthorization(clientId: clientId, customParams: {
  //     'show_dialog': 'true'
  //   }, scopes: [
  //     'user-read-private',
  //     'user-read-playback-state',
  //     'user-modify-playback-state',
  //     'user-read-currently-playing',
  //     'user-read-email'
  //   ]);
  //   var authCode = authResp.code;

  //   accessToken = await client.requestAccessToken(
  //       code: authCode.toString(),
  //       clientId: clientId,
  //       clientSecret: clientSecret);

  //   // Global variables
  //   Access_Token = accessToken.accessToken;
  //   Refresh_Token = accessToken.refreshToken;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => SpotifyAuthPage(onCodeReceived: (c) {}),
          '/calendar': (context) => Navbar2(),
          //'/events': (context) => Navbar2(),
          //   '/festical': (context) => festical(),
          '/settings': (context) => Settings(),
          //   '/recommendations': (context) => recommendations(),
        },
        title: 'MusiCAL',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1F2421)),
          useMaterial3: true,
        ));
  }
}
