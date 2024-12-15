import 'package:flutter/material.dart';
import 'package:new_university_communication/service/service.dart';
import 'package:new_university_communication/shared_widgets/custom_appbar.dart';
import 'package:new_university_communication/shared_widgets/custom_button.dart';
import 'package:new_university_communication/thems/thems.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Service service = Service.defaultInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Admin"),
      backgroundColor: Thems.mainBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
                onPressed: (() async {
                  final key = await service.generateRSAKeyPairInIsolate();
                  print(key);
                  print(service.derivePublicKeyFromPrivate(key["privateKey"]!));
                }),
                text: "Create key pair"),
            SizedBox(height: 15),
            CustomButton(
                onPressed: (() async {}), text: "Add key pair to student"),
            SizedBox(height: 15),
            CustomButton(
                onPressed: (() async {}),
                text: "Add | Update | Delete student"),
            SizedBox(height: 15),
            CustomButton(
                onPressed: (() async {}),
                text: "Add | Update | Delete teacher"),
            SizedBox(height: 15),
            CustomButton(onPressed: (() async {}), text: "Settings"),
          ],
        ),
      ),
    );
  }
}
