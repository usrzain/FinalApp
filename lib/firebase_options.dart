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
    apiKey: 'AIzaSyCOi-5qkdlBJaG570NBz-DkHToSm5IBiSo',
    appId: '1:254103199108:web:6f284d80a69a1ed69091d1',
    messagingSenderId: '254103199108',
    projectId: 'evapp-a4979',
    authDomain: 'evapp-a4979.firebaseapp.com',
    databaseURL:
        'https://evapp-a4979-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'evapp-a4979.appspot.com',
    measurementId: 'G-35PGWTEM2P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLGTSrEMfnyvFlfGIFzXkowla4hCoA71k',
    appId: '1:254103199108:android:9b10bd9233a6a0e99091d1',
    messagingSenderId: '254103199108',
    projectId: 'evapp-a4979',
    databaseURL:
        'https://evapp-a4979-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'evapp-a4979.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmGh-UW7rAAA704hDCQbxxsF_a_U6pR0g',
    appId: '1:254103199108:ios:dcc03d23100a31929091d1',
    messagingSenderId: '254103199108',
    projectId: 'evapp-a4979',
    databaseURL:
        'https://evapp-a4979-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'evapp-a4979.appspot.com',
    androidClientId:
        '254103199108-r2o8brob1jq6jn9igoaukjbrr31bmrr0.apps.googleusercontent.com',
    iosClientId:
        '254103199108-6dsb7o1vi4hahkv8ao0lld35q1f4u2mf.apps.googleusercontent.com',
    iosBundleId: 'com.example.effecient',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmGh-UW7rAAA704hDCQbxxsF_a_U6pR0g',
    appId: '1:254103199108:ios:bbfa6de79328753b9091d1',
    messagingSenderId: '254103199108',
    projectId: 'evapp-a4979',
    databaseURL:
        'https://evapp-a4979-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'evapp-a4979.appspot.com',
    androidClientId:
        '254103199108-r2o8brob1jq6jn9igoaukjbrr31bmrr0.apps.googleusercontent.com',
    iosClientId:
        '254103199108-m1v88h19f1qt0c7hchdnrd5dqq9ee9a5.apps.googleusercontent.com',
    iosBundleId: 'com.example.effecient.RunnerTests',
  );
}
