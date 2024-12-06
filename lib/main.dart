import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_university_communication/modules/app_module.dart';
import 'package:new_university_communication/routes/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    // initialize Supabase
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
    );
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
