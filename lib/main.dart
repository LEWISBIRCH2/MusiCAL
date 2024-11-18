import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musical/pages/spotify_auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*   if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBtpe67Ioc4cGAF41pJqxa6sJGmNIOo2YQ",
            authDomain: "musical-5846f.firebaseapp.com",
            databaseURL: "https://musical-5846f-default-rtdb.firebaseio.com",
            projectId: "musical-5846f",
            storageBucket: "musical-5846f.firebasestorage.app",
            messagingSenderId: "514047598246",
            appId: "1:514047598246:web:81590b3c5b79f230e61e67",
            measurementId: "G-WJQHDWKMXE"));
  } else {
    await Firebase.initializeApp();
  } */
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  var code = '';
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Placeholder();
        break;
      case 1:
        page = SpotifyAuthPage(
          onCodeReceived: (c) {
            code = c;
            selectedIndex = 0;
            setState(() {});
          },
        );
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }
    {
      return Scaffold(
        appBar: AppBar(
          title: Text('Spotify Login'),
        ),
        body: Center(
            child: Column(children: [
          ElevatedButton(
              onPressed: () {
                selectedIndex = 1;
                setState(() {});
              },
              child: Text('Login')),
          Expanded(child: page)
        ])),
      );
    }
  }
}
