import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const web = FirebaseOptions(
    apiKey: 'AIzaSyAwPoKmQCw1DeGYmbOLDOjNRDXK82LrSec',
    appId: '1:86032851224:web:YOUR_WEB_APP_ID',
    messagingSenderId: '86032851224',
    projectId: 'movie-ef056',
    authDomain: 'movie-ef056.firebaseapp.com',
  );

  static const android = FirebaseOptions(
    apiKey: 'AIzaSyAwPoKmQCw1DeGYmbOLDOjNRDXK82LrSec',
    appId: '1:86032851224:android:efbb4af312d51522347e6d',
    messagingSenderId: '86032851224',
    projectId: 'movie-ef056',
  );

  static const ios = FirebaseOptions(
    apiKey: 'AIzaSyAwPoKmQCw1DeGYmbOLDOjNRDXK82LrSec',
    appId: '1:86032851224:ios:YOUR_IOS_APP_ID',
    messagingSenderId: '86032851224',
    projectId: 'movie-ef056',
    iosBundleId: 'com.route.movie',
  );

  static FirebaseOptions get currentPlatform {
    return android;
  }
}
