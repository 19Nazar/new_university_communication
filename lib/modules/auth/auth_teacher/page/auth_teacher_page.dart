import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:new_university_communication/models/models.dart';
import 'package:new_university_communication/service/service.dart';
import 'package:new_university_communication/shared_widgets/custom_appbar.dart';
import 'package:new_university_communication/shared_widgets/custom_button.dart';
import 'package:new_university_communication/thems/thems.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthTeacherPage extends StatefulWidget {
  const AuthTeacherPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthTeacherPage> createState() => _AuthTeacherPageState();
}

class _AuthTeacherPageState extends State<AuthTeacherPage> {
  Service service = Service.defaultInstance();
  final TextEditingController eventController = TextEditingController();
  final TextEditingController eventDetailsController = TextEditingController();
  List<Map<String, dynamic>>? groupsData;
  List<int> selectedGroupIds = [];
  Map<String, dynamic>? data;

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
    final res = jsonDecode(notData!);

    final getGroupsData = await service.readDB(table_name: "groups");
    groupsData = getGroupsData.data;
    setState(() {
      data = res["teacher"];
      groupsData = getGroupsData.data;
    });
  }

  void createNotifiacation(
      {required String event,
      required String event_details,
      required List<int> groups_id}) async {
    List<String>? tokens;
    DateTime now = DateTime.now();
    if (groups_id.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("You must choose group"),
        ),
      );
    }

    final resDB = await service.readDB(
        table_name: "student",
        select: "token",
        filterColumnIn: "group_id",
        filterIn: groups_id);
    if (resDB.status == Status.successful) {
      tokens = resDB.data
          .map((e) => e['token'])
          .where((token) => token != null)
          .cast<String>()
          .toList();
    }

    String formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    if (tokens != null) {
      // final resNotification = service.sendNotification(
      //     tokens: tokens, title: event, body: event_details);
      // if (resNotification == true) {
      final createData = await service.createDB(data: {
        "creator_id": data!["id"],
        "event": event,
        "event_details": event_details,
        "time_create_event": formattedTimestamp,
        "groups_id": groups_id
      }, table_name: "event_history");
      if (createData.status == Status.successful) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Successful"),
            content: Text("${createData.data}"),
          ),
        );
      }
      // } else {
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text("Error"),
      //       content: Text("Error create notification"),
      //     ),
      //   );
      // }
    }
    print({
      "event": event,
      "event_details": event_details,
      "groups_id": groups_id,
      "formattedTimestamp": formattedTimestamp,
      "groups_id": groups_id,
      'tokens': tokens,
    });
    // final createData = await service.createDB(data: {
    //   "creator_id": widget.args["id"],
    //   "event": event,
    //   "event_details": event_details,
    //   "time_create_event": formattedTimestamp,
    //   "groups_id": groups_id
    // }, table_name: "event_history");
  }

  void showNotificationModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: StatefulBuilder(
              builder: (context, setModalState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: eventController,
                      decoration:
                          InputDecoration(labelText: "Input event name: "),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: eventDetailsController,
                      decoration:
                          InputDecoration(labelText: "Input event details: "),
                    ),
                    SizedBox(height: 10),
                    groupsData == null
                        ? Text("Data about groups not loaded")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Select groups:",
                                  style: TextStyle(fontSize: 16)),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: groupsData!.length,
                                itemBuilder: (context, index) {
                                  final group = groupsData![index];
                                  return CheckboxListTile(
                                    value:
                                        selectedGroupIds.contains(group["id"]),
                                    title: Text(group["group"]),
                                    onChanged: (bool? selected) {
                                      setModalState(() {
                                        if (selected == true) {
                                          if (!selectedGroupIds
                                              .contains(group["id"])) {
                                            selectedGroupIds.add(group["id"]);
                                          }
                                        } else {
                                          selectedGroupIds.remove(group["id"]);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                    SizedBox(height: 20),
                    CustomButton(
                      onPressed: () async {
                        createNotifiacation(
                          event: eventController.text,
                          event_details: eventDetailsController.text,
                          groups_id: selectedGroupIds,
                        );
                        Navigator.pop(context);
                      },
                      text: "Create notification",
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("data");
    Modular.to.pushNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Teacher"),
      backgroundColor: Thems.mainBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("You log in by ${data?["surname"]} ${data?["name"]}"),
                CustomButton(onPressed: () => logOut(), text: "Log Out"),
              ],
            ),
          ),
          Spacer(),
          Center(
            child: CustomButton(
              onPressed: () => showNotificationModal(),
              text: "Create notification",
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
