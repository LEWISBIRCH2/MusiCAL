import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
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
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MusiCAL',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1f2421)),
          useMaterial3: true,
        ),
        home: const Login());
    // appBarApp: const AppBarApp());
  }
}
