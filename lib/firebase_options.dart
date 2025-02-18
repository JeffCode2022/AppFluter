// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyDxbY5b-w6GCFWwjEvELJ_Vr4-5wb_FPlM',
    appId: '1:260881124086:web:d3da8c444ad42bc650fad7',
    messagingSenderId: '260881124086',
    projectId: 'appdelivery-auth',
    authDomain: 'appdelivery-auth.firebaseapp.com',
    storageBucket: 'appdelivery-auth.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgg4xPrlSJIlo5nFPY9SD3YICfN_vt5hU',
    appId: '1:260881124086:android:81ab989ffa72238950fad7',
    messagingSenderId: '260881124086',
    projectId: 'appdelivery-auth',
    storageBucket: 'appdelivery-auth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbJU_nT5SdP7nd_X7EMo6vLZ3NXv7NjLc',
    appId: '1:260881124086:ios:10a49a2d834481a650fad7',
    messagingSenderId: '260881124086',
    projectId: 'appdelivery-auth',
    storageBucket: 'appdelivery-auth.appspot.com',
    iosBundleId: 'com.example.deliveryAutonoma',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbJU_nT5SdP7nd_X7EMo6vLZ3NXv7NjLc',
    appId: '1:260881124086:ios:352ad517b6df98d550fad7',
    messagingSenderId: '260881124086',
    projectId: 'appdelivery-auth',
    storageBucket: 'appdelivery-auth.appspot.com',
    iosBundleId: 'com.example.deliveryAutonoma.RunnerTests',
  );
}
