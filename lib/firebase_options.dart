// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKkx-Ybudg_YuBMUO7j0RaNBq6PXVeMR0',
    appId: '1:859378346519:android:e059fd2360251475850a52',
    messagingSenderId: '859378346519',
    projectId: 'rickshare-2c34e',
    storageBucket: 'rickshare-2c34e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDq62VuDEZfQnUMppIANE0tqcZ96_Bf7Jo',
    appId: '1:859378346519:ios:4ac5bf5731547057850a52',
    messagingSenderId: '859378346519',
    projectId: 'rickshare-2c34e',
    storageBucket: 'rickshare-2c34e.appspot.com',
    iosBundleId: 'com.example.rickshare',
  );
}