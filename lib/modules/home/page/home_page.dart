import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/models/models.dart';
import 'package:new_university_communication/shared_widgets/custom_appbar.dart';
import 'package:new_university_communication/shared_widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/service.dart';
import '../../../thems/thems.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String platformVersion = '';

  final TextEditingController privetKeyController = TextEditingController();

  Service service = Service.defaultInstance();

  @override
  void initState() {
    // final key = service.generateRSAKeyPair();
    // print(key);
    // print(service.derivePublicKeyFromPrivate(key.privateKey));
    super.initState();
  }

  Future<void> readData() async {
    final res = await service.readDB(table_name: "groups", select: "*");
    print(res.data);
  }

  Future<void> createData() async {
    final res = await service.createDB(
        data: {"group": "ІСДМ-62", "department_id": 1}, table_name: "groups");
    print(res.data);
  }

  Future<void> updateData() async {
    final res = await service.updateDB(
        table_name: "groups",
        id: 4,
        data: {"group": "ІСДМ-60", "department_id": 1});
    print(res.data);
  }

  Future<void> deleteData() async {
    final res = await service.delete(id: 4, table_name: "groups");
    print(res.data);
  }

  Future<void> logIn({required String pubKey}) async {
    final user = await service.logIn(publicKey: pubKey);
    final userData = user.data;

    if (userData.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const Text("User not found"),
      );
      return;
    }

    if (userData.first["teacher_id"] != null) {
      final data =
          await service.getTeacherRows(id: userData.first["teacher_id"]);
      if (data == Status.successful) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("data", jsonEncode(data.data.first));
        Modular.to.pushNamed("//home/auth-teacher-module",
            arguments: data.data.first);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(
                "Notify the administration of the error ${data.data.toString()}"),
          ),
        );
      }
    } else if (userData.first["student_id"] != null) {
      final data =
          await service.getTeacherRows(id: userData.first["student_id"]);
      if (data == Status.successful) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("data", jsonEncode(data.data.first));
        Modular.to.pushNamed("//home/auth-teacher-module",
            arguments: data.data.first);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(
                "Notify the administration of the error ${data.data.toString()}"),
          ),
        );
      }
      Modular.to.pushNamed("//home/auth-student-module");
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Notify the administration of the error"),
        ),
      );
    }
  }

  void showLoginModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: privetKeyController,
                  decoration: InputDecoration(labelText: "Input privet key: "),
                ),
                CustomButton(
                    onPressed: () async {
                      logIn(pubKey: privetKeyController.text);
                    },
                    text: "Log In")
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "New University Communication"),
      backgroundColor: Thems.mainBackgroundColor,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
                onPressed: (() async {
                  await readData();
                }),
                text: "readData"),
            SizedBox(height: 10),
            CustomButton(
                onPressed: (() async {
                  await createData();
                }),
                text: "createData"),
            SizedBox(height: 10),
            CustomButton(
                onPressed: (() async {
                  await updateData();
                }),
                text: "updateData"),
            SizedBox(height: 10),
            CustomButton(
                onPressed: (() async {
                  final key = await service.generateRSAKeyPairInIsolate();
                  print(key);
                  print(service.derivePublicKeyFromPrivate(key["privateKey"]!));
                }),
                text: "deleteData"),
            SizedBox(height: 10),
            CustomButton(
                onPressed: (() => showLoginModal()),
                text: "Student card ID number"),
            SizedBox(height: 10),
            CustomButton(
                onPressed: (() => {Modular.to.pushNamed("//home/admin")}),
                text: "Admin"),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
