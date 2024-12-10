import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/shared_widgets/custom_appbar.dart';
import 'package:new_university_communication/shared_widgets/custom_button.dart';

import '../../../service/service.dart';
import '../../../thems/thems.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String platformVersion = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "New University Communication"),
      backgroundColor: Thems.mainBackgroundColor,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
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
                  final key = await service.generateRSAKeyPair();
                  print(key);
                  print(service.derivePublicKeyFromPrivate().toString());
                }),
                text: "deleteData"),
            SizedBox(height: 10),
            CustomButton(
                onPressed: (() {
                  Modular.to.pushNamed('//home/auth-teacher-module');
                }),
                text: "Student card ID number"),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
