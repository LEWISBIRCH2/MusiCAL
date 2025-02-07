import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBtpe67Ioc4cGAF41pJqxa6sJGmNIOo2YQ',
    appId: '1:514047598246:web:81590b3c5b79f230e61e67',
    messagingSenderId: '514047598246',
    projectId: 'musical-5846f',
    authDomain: 'musical-5846f.firebaseapp.com',
    databaseURL: 'https://musical-5846f-default-rtdb.firebaseio.com',
    storageBucket: 'musical-5846f.firebasestorage.app',
    measurementId: 'G-WJQHDWKMXE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANkPkjnXfBE096_FVIQS1-YsMCrOsqVrU',
    appId: '1:514047598246:android:de1edfcf5bc48b23e61e67',
    messagingSenderId: '514047598246',
    projectId: 'musical-5846f',
    databaseURL: 'https://musical-5846f-default-rtdb.firebaseio.com',
    storageBucket: 'musical-5846f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADufJ2CO4Y6v4W52xD0uvyydN0GFgNteM',
    appId: '1:514047598246:ios:087bb726323a1e4be61e67',
    messagingSenderId: '514047598246',
    projectId: 'musical-5846f',
    databaseURL: 'https://musical-5846f-default-rtdb.firebaseio.com',
    storageBucket: 'musical-5846f.firebasestorage.app',
    iosBundleId: 'com.example.musical',
  );
}
