import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_university_communication/modules/app_module.dart';
import 'package:new_university_communication/routes/routes.dart';
import 'package:new_university_communication/service/push_notification.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received");
  }
}

void showNotification({
  required BuildContext context,
  required String title,
  required String body,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    // initialize Supabase
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
    );
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Background Notification Tapped");
        navigatorKey.currentState!.pushNamed("/message", arguments: message);
      }
    });
    PushNotifications.init();
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);
      print(
          "Got a message in foreground ${message.notification!.title}, ${message.notification!.title}");
      if (message.notification != null) {
        if (kIsWeb) {
          Modular.to.pushNamed(Routes.template.notificationHandler, arguments: {
            "title": message.notification!.title,
            "body": message.notification!.body
          });
        }
      }
    });

    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      print("Launched from terminated state");
      Future.delayed(Duration(seconds: 1), () {
        navigatorKey.currentState!.pushNamed("/message", arguments: message);
      });
    }
    //Catch Errors caught by Flutter
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      //TODO add catcher
    };

    runApp(ModularApp(module: AppModule(), child: AppWidget()));
  }, (error, stack) {
    print(error.toString());
    //Catch Errors not caught by Flutter
    //TODO add catcher
  });
}

class AppWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AppWidget();

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(Routes.home.module);
    ScreenUtil.init(context);
    ScreenUtil.configure(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'NEW UNIVERSITY COMMUNICATION',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
