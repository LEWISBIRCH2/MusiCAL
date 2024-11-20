import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:musical/pages/spotify_auth_page.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:oauth2_client/access_token_response.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:provider/provider.dart';

import 'settings.dart';
// import 'package:musical/pages/spotify_auth_page.dart';
import 'defaulttab.dart';
// import 'package:http/http.dart' as http;
import 'package:musical/firebase_options.dart';
import 'bottomnavbar.dart';
import 'calendar.dart';

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
        home: Navigation(),
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
                ElevatedButton(
                    onPressed: () {
                      getToken();
                    },
                    child: Text('Login')),
                Text(accessToken.toString()),
              ],
            )),
          )
        : SpotifyAuthPage(onCodeReceived: (code) {
            accessToken = code;
          });
  }
}

// class _SpotifyLoginState extends StatefulWidget {
//   const _SpotifyLoginState();

//   @override
//   State<_SpotifyLoginState> createState() => __SpotifyLoginStateState();
// }

// class __SpotifyLoginStateState extends State<_SpotifyLoginState> {
//   String? accessToken = '';
//   String? refreshToken = '';

//   Future<void> remoteService() async {
//     final String clientId = '809e9a055f604342a727aa3961f343d2';
//     final String clientSecret = '6aa9ae2264094650a6af77b3eef14903';
//     AccessTokenResponse? accessT;
//     SpotifyOAuth2Client client = SpotifyOAuth2Client(
//       customUriScheme: 'app',
//       redirectUri: 'https://dapper-swan-46f09f.netlify.app',
//     );
//     var authResp =
//         await client.requestAuthorization(clientId: clientId, scopes: [
//       'user-read-private',
//       'user-read-playback-state',
//       'user-modify-playback-state',
//       'user-read-currently-playing',
//       'user-read-email'
//     ]);
//     var authCode = authResp.code;

//     accessT = await client.requestAccessToken(
//         code: authCode.toString(),
//         clientId: clientId,
//         clientSecret: clientSecret);

//     // Global variables
//     accessToken = accessT.accessToken;
//     refreshToken = accessT.refreshToken;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Center(
//           child: Column(children: [
//         ElevatedButton(
//             onPressed: () {
//               remoteService();
//             },
//             child: Text('login'))
//       ])),
//     );
//   }
// }
