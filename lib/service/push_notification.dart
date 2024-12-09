import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  // static final FlutterLocalNotificationsPlugin
  //     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // request notification permission
  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    getFCMToken();
  }

// get the fcm device token
  static Future getFCMToken({int maxRetires = 3}) async {
    try {
      String? token;
      if (kIsWeb) {
        // get the device fcm token
        token = await _firebaseMessaging.getToken(
            vapidKey:
                "BAyP3DGrafDbVk74UC_OaW5IXuhj245yQvSiVqk0AyYDX-66nIisq6R_0QmSuqd65YQb6G6bPM_XcmkJDWdPFFc");
        print("for web device token: $token");
      } else {
        // get the device fcm token
        token = await _firebaseMessaging.getToken();
        print("for android device token: $token");
      }
      return token;
    } catch (e) {
      print("failed to get device token");
      if (maxRetires > 0) {
        print("try after 3 sec");
        await Future.delayed(Duration(seconds: 3));
        return getFCMToken(maxRetires: maxRetires - 1);
      } else {
        return null;
      }
    }
  }
}
