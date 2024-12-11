import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/service/push_notification.dart';
import 'package:new_university_communication/service/service.dart';
import 'package:new_university_communication/shared_widgets/custom_appbar.dart';
import 'package:new_university_communication/shared_widgets/custom_button.dart';
import 'package:new_university_communication/thems/thems.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthTeacherPage extends StatefulWidget {
  final Map<String, dynamic> args;
  const AuthTeacherPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<AuthTeacherPage> createState() => _AuthTeacherPageState();
}

class _AuthTeacherPageState extends State<AuthTeacherPage> {
  Service service = Service.defaultInstance();

  @override
  void initState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final notData = prefs.getString("data");
    if (notData == null) {
      Modular.to.pushNamed("/");
    }
    final data = jsonDecode(notData!);
    if (data["token"] == null) {
      final token = await PushNotifications.getFCMToken();
      service.updateDB(
          table_name: "teacher",
          id: data["id"],
          data: {"token": token.toString()});
    }
    super.initState();
  }

  void createNotifiacation(
      {required String creator_id,
      required String event,
      required String event_details,
      required String time_create_event,
      required String group_id}) async {
    final createData = await service.createDB(data: {
      "creator_id": creator_id,
      "event": event,
      "event_details": event_details,
      "time_create_event": time_create_event,
      "group_id": group_id
    }, table_name: "event_history");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Teacher"),
      backgroundColor: Thems.mainBackgroundColor,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "You log in by ${widget.args["surname"]} ${widget.args["name"]}"),
            CustomButton(onPressed: () {}, text: "Log Out"),
            CustomButton(onPressed: () {}, text: "Create notification")
          ],
        ),
      ),
    );
  }
}
