import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/service/push_notification.dart';
import 'package:new_university_communication/service/service.dart';
import 'package:new_university_communication/shared_widgets/custom_appbar.dart';
import 'package:new_university_communication/thems/thems.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStudentPage extends StatefulWidget {
  const AuthStudentPage({super.key});

  @override
  State<AuthStudentPage> createState() => _AuthStudentPageState();
}

class _AuthStudentPageState extends State<AuthStudentPage> {
  Service service = Service.defaultInstance();

  Map<String, dynamic>? data;

  @override
  void initState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final notData = prefs.getString("data");
    if (notData == null) {
      Modular.to.pushNamed("/");
    }
    final data = jsonDecode(notData!);
    this.data = data;
    if (data["token"] == null) {
      final token = await PushNotifications.getFCMToken();
      service.updateDB(
          table_name: "student",
          id: data["id"],
          data: {"token": token.toString()});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Student"),
      backgroundColor: Thems.mainBackgroundColor,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "You log in by ${this.data!["surname"]} ${this.data!["name"]}"),
          ],
        ),
      ),
    );
  }
}
