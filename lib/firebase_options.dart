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
    apiKey: 'AIzaSyDLnTChWbj1Vrjl6XxlHL7tQicoOsoAzNs',
    appId: '1:81760973330:web:0ccb79abba8bf1c1881ecb',
    messagingSenderId: '81760973330',
    projectId: 'remindwater-ecf92',
    authDomain: 'remindwater-ecf92.firebaseapp.com',
    storageBucket: 'remindwater-ecf92.firebasestorage.app',
    measurementId: 'G-T4E2Y7R9XL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgoJOY34THNa1UQ1cCCEhSZIAlwuV0yQk',
    appId: '1:81760973330:android:d62628798944ddff881ecb',
    messagingSenderId: '81760973330',
    projectId: 'remindwater-ecf92',
    storageBucket: 'remindwater-ecf92.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFH_QHsMB-MxBKJ9j_4Lk3RwjqrhgcUtI',
    appId: '1:81760973330:ios:01ed8ced28a19212881ecb',
    messagingSenderId: '81760973330',
    projectId: 'remindwater-ecf92',
    storageBucket: 'remindwater-ecf92.firebasestorage.app',
    iosBundleId: 'com.cezrt.remindWater',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFH_QHsMB-MxBKJ9j_4Lk3RwjqrhgcUtI',
    appId: '1:81760973330:ios:01ed8ced28a19212881ecb',
    messagingSenderId: '81760973330',
    projectId: 'remindwater-ecf92',
    storageBucket: 'remindwater-ecf92.firebasestorage.app',
    iosBundleId: 'com.cezrt.remindWater',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDLnTChWbj1Vrjl6XxlHL7tQicoOsoAzNs',
    appId: '1:81760973330:web:f52019c33ed3ffd5881ecb',
    messagingSenderId: '81760973330',
    projectId: 'remindwater-ecf92',
    authDomain: 'remindwater-ecf92.firebaseapp.com',
    storageBucket: 'remindwater-ecf92.firebasestorage.app',
    measurementId: 'G-1941Q5MSVG',
  );
}
