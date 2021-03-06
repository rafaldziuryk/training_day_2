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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAM-f8J8Xn7RNfX4Hqp24UmHM_1qQximV0',
    appId: '1:925123791738:android:d911c2ba8eb6eb6bf164c3',
    messagingSenderId: '925123791738',
    projectId: 'magisterka-9b042',
    databaseURL: 'https://magisterka-9b042.firebaseio.com',
    storageBucket: 'magisterka-9b042.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAo0dPBS8jUaWTe7N7QDlEreAbZ7a2HOl0',
    appId: '1:925123791738:ios:f1700afa4b9cf65bf164c3',
    messagingSenderId: '925123791738',
    projectId: 'magisterka-9b042',
    databaseURL: 'https://magisterka-9b042.firebaseio.com',
    storageBucket: 'magisterka-9b042.appspot.com',
    androidClientId: '925123791738-dunnql9mabgu9l256k343ejj4c5c8f7p.apps.googleusercontent.com',
    iosClientId: '925123791738-qk8ptrm0aid1esfor5q5id9j65mavohn.apps.googleusercontent.com',
    iosBundleId: 'pl.bertek.quizApp',
  );
}
