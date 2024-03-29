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
    apiKey: 'AIzaSyBWK-MEoRQJ3et5j49tITSIQvSYlmjTtLo',
    appId: '1:376534966992:web:205e6915e6965854e334d5',
    messagingSenderId: '376534966992',
    projectId: 'todos-87f8c',
    authDomain: 'todos-87f8c.firebaseapp.com',
    storageBucket: 'todos-87f8c.appspot.com',
    measurementId: 'G-8Z3J5REZM0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbaACjdtGhhnH0f-iF9QzrvnaoPXyPRHY',
    appId: '1:376534966992:android:4b9a720c1bc911b5e334d5',
    messagingSenderId: '376534966992',
    projectId: 'todos-87f8c',
    storageBucket: 'todos-87f8c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDq-fC66OWee0UkhN9bYZNuRN9iUp3ocbo',
    appId: '1:376534966992:ios:48c86a8bd1253f22e334d5',
    messagingSenderId: '376534966992',
    projectId: 'todos-87f8c',
    storageBucket: 'todos-87f8c.appspot.com',
    iosBundleId: 'com.example.todos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDq-fC66OWee0UkhN9bYZNuRN9iUp3ocbo',
    appId: '1:376534966992:ios:5de64fc865f531aae334d5',
    messagingSenderId: '376534966992',
    projectId: 'todos-87f8c',
    storageBucket: 'todos-87f8c.appspot.com',
    iosBundleId: 'com.example.todos.RunnerTests',
  );
}
