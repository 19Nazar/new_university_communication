import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/service/push_notification.dart';
import 'package:new_university_communication/service/service.dart';
import 'package:new_university_communication/shared_widgets/custom_appbar.dart';
import 'package:new_university_communication/shared_widgets/custom_button.dart';
import 'package:new_university_communication/thems/thems.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStudentPage extends StatefulWidget {
  const AuthStudentPage({super.key});

  @override
  State<AuthStudentPage> createState() => _AuthStudentPageState();
}

class _AuthStudentPageState extends State<AuthStudentPage> {
  Service service = Service.defaultInstance();

  Map<String, dynamic>? dataFinal;

  @override
  void initState() {
    initFunc();
    super.initState();
  }

  Future<void> initFunc() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final notData = prefs.getString("data");
    if (notData == null) {
      Modular.to.pushNamed("/");
    }
    final data = jsonDecode(notData!);
    setState(() {
      dataFinal = data["student"];
    });

    final historyNotification = await service.fetchEventHistory();
    // print(historyNotification);
  }

  void logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("data");
    Modular.to.pushNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Student"),
      backgroundColor: Thems.mainBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "You log in by ${dataFinal?["surname"]} ${dataFinal?["name"]}"),
                CustomButton(onPressed: () => logOut(), text: "Log Out"),
              ],
            ),
          ),
          Spacer(),
          Center(child: Text("test")),
          Spacer(),
        ],
      ),
    );
  }
}
