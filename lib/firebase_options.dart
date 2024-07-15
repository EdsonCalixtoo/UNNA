// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBMk9FGFuVB4bezwHeBIBXFxYYGkAFIwsQ',
    appId: '1:685505780771:web:b2ec31e96178eff2712596',
    messagingSenderId: '685505780771',
    projectId: 'unna-374aa',
    authDomain: 'unna-374aa.firebaseapp.com',
    databaseURL: 'https://unna-374aa-default-rtdb.firebaseio.com',
    storageBucket: 'unna-374aa.appspot.com',
    measurementId: 'G-HTXV6N7JP0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQpikI4HNh-5UvLy4B0QyngdYT3ya7jLo',
    appId: '1:685505780771:android:1614a4d1da234d14712596',
    messagingSenderId: '685505780771',
    projectId: 'unna-374aa',
    databaseURL: 'https://unna-374aa-default-rtdb.firebaseio.com',
    storageBucket: 'unna-374aa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyCzyIC7q7nUugl4eaAj3Y2HGm6XP2hSE',
    appId: '1:685505780771:ios:dbeb5ed93cff1a3d712596',
    messagingSenderId: '685505780771',
    projectId: 'unna-374aa',
    databaseURL: 'https://unna-374aa-default-rtdb.firebaseio.com',
    storageBucket: 'unna-374aa.appspot.com',
    iosClientId: '685505780771-c3s68554otlapg5a3o4escpefgj6kq7l.apps.googleusercontent.com',
    iosBundleId: 'com.unna.social.unna',
  );
}
