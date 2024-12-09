// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
    apiKey: 'AIzaSyC90gQD2u9D5jrtkfLRi-tICXTZHJSo6aY',
    appId: '1:1044858124129:web:121410f0e9d7cd45d9f720',
    messagingSenderId: '1044858124129',
    projectId: 'new-university-communication',
    authDomain: 'new-university-communication.firebaseapp.com',
    storageBucket: 'new-university-communication.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2F61wrRR2uf2YBtJma6GAlrwF3E3UQYE',
    appId: '1:1044858124129:android:dc4faf63e3503a82d9f720',
    messagingSenderId: '1044858124129',
    projectId: 'new-university-communication',
    storageBucket: 'new-university-communication.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0pqJf5ZzspmbY6tmvYSRW0d6l_t6-5vY',
    appId: '1:1044858124129:ios:922009472ede06e3d9f720',
    messagingSenderId: '1044858124129',
    projectId: 'new-university-communication',
    storageBucket: 'new-university-communication.firebasestorage.app',
    iosBundleId: 'com.example.newUniversityCommunication',
  );
}
