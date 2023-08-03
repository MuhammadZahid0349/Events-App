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
    apiKey: 'AIzaSyDAzAPve2rOsK32k5rJpI4bJt8iCYpiA6A',
    appId: '1:280923563161:web:a596226a8e6dafd4acc408',
    messagingSenderId: '280923563161',
    projectId: 'event-management-a5470',
    authDomain: 'event-management-a5470.firebaseapp.com',
    storageBucket: 'event-management-a5470.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4WYpDcmXti8U7dVjSCSQlliHEKaSouJw',
    appId: '1:280923563161:android:10629f02cf6204dfacc408',
    messagingSenderId: '280923563161',
    projectId: 'event-management-a5470',
    storageBucket: 'event-management-a5470.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeFjLIMcYx7iX8S1coH3fARJDv9IM81xw',
    appId: '1:280923563161:ios:f5b494a8afa006ffacc408',
    messagingSenderId: '280923563161',
    projectId: 'event-management-a5470',
    storageBucket: 'event-management-a5470.appspot.com',
    iosClientId: '280923563161-h8rev07lbsu83f1fhlhve0722trhlou0.apps.googleusercontent.com',
    iosBundleId: 'com.example.eventManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeFjLIMcYx7iX8S1coH3fARJDv9IM81xw',
    appId: '1:280923563161:ios:f5b494a8afa006ffacc408',
    messagingSenderId: '280923563161',
    projectId: 'event-management-a5470',
    storageBucket: 'event-management-a5470.appspot.com',
    iosClientId: '280923563161-h8rev07lbsu83f1fhlhve0722trhlou0.apps.googleusercontent.com',
    iosBundleId: 'com.example.eventManagement',
  );
}
