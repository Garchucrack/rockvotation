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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDT77oS3-CnXP0X9Cayg68YZYfHGzNYH7Q',
    appId: '1:601252701879:web:a002da12dba65810e8cf32',
    messagingSenderId: '601252701879',
    projectId: 'online-store-40828',
    authDomain: 'online-store-40828.firebaseapp.com',
    storageBucket: 'online-store-40828.appspot.com',
    measurementId: 'G-ZLE1MBHEPV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBu0LsAN1qwauY_HL6bhW2LWdU5ypUbWCo',
    appId: '1:601252701879:android:d58a06daebd47cb8e8cf32',
    messagingSenderId: '601252701879',
    projectId: 'online-store-40828',
    storageBucket: 'online-store-40828.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEfMVL2c1xYufPKl0L_bOsLRUoKTK2n-c',
    appId: '1:601252701879:ios:33e4c8e705346a9be8cf32',
    messagingSenderId: '601252701879',
    projectId: 'online-store-40828',
    storageBucket: 'online-store-40828.appspot.com',
    iosBundleId: 'com.example.onlineStoreTk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEfMVL2c1xYufPKl0L_bOsLRUoKTK2n-c',
    appId: '1:601252701879:ios:33e4c8e705346a9be8cf32',
    messagingSenderId: '601252701879',
    projectId: 'online-store-40828',
    storageBucket: 'online-store-40828.appspot.com',
    iosBundleId: 'com.example.onlineStoreTk',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDT77oS3-CnXP0X9Cayg68YZYfHGzNYH7Q',
    appId: '1:601252701879:web:f98e6390e2f3821ce8cf32',
    messagingSenderId: '601252701879',
    projectId: 'online-store-40828',
    authDomain: 'online-store-40828.firebaseapp.com',
    storageBucket: 'online-store-40828.appspot.com',
    measurementId: 'G-R1KHGZ7ZZY',
  );
}
