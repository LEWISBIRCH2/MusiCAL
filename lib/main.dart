import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musical/pages/spotify_auth_page.dart';

import 'defaulttab.dart';

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
        initialRoute: '/login',
        routes: {
          '/login': (context) => Login(),
          // '/calendar': (context) => Navbar2()
          '/events': (context) => Navbar2(),
          //   '/festical': (context) => festical(),
          //   '/settings': (context) => settings(),
          //   '/recommendations': (context) => recommendations(),
        },
        title: 'MusiCAL',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1f2421)),
          useMaterial3: true,
        ));
  }
}
