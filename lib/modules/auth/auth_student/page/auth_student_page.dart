import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
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
  List<Map<String, dynamic>>? historyNotification;

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

    final getHistoryNotification =
        await service.fetchEventHistory(id: data["student"]["id"]);
    setState(() {
      dataFinal = data["student"];
      historyNotification = getHistoryNotification.data;
    });
  }

  void logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("data");
    Modular.to.pushNamed("/");
  }

  String formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return DateFormat('dd.MM.yyyy HH:mm').format(date);
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
                    "You log in by ${dataFinal?["surname"]} ${dataFinal?["name"]}",
                    style: TextStyle(fontSize: 20, height: 1.4),
                  ),
                  CustomButton(onPressed: () => logOut(), text: "Log Out"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            historyNotification == null
                ? const Center(
                    child: Text("No data Load",
                        style: TextStyle(fontSize: 20, height: 1.4)))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: historyNotification!.length,
                    itemBuilder: (context, index) {
                      final event = historyNotification![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event['event'] ?? 'Подія',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Деталі: ${event['event_details'] ?? 'Немає'}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Час створення: ${formatDate(event['time_create_event']) ?? 'Невідомо'}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Викладач: ${event['teacher_name'] ?? ''} ${event['teacher_surname'] ?? ''}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Кафедра: ${event['department_name'] ?? 'Невідомо'}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ));
  }
}
