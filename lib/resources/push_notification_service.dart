import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    _fcm.configure(
        //Called when App is in Foreground
        onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
    },
        // Called when app is closed completely
        onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');
    },
        // Called when app is in background
        onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
    });
  }
}
