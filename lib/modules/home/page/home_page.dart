import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/shared_widgets/custom_appbar.dart';
import 'package:new_university_communication/shared_widgets/custom_button.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

import '../../../thems/thems.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nfcData = "No data yet";

  // Future<void> scanNFC() async {
  //   try {
  //     final availability = await FlutterNfcKit.nfcAvailability;
  //     if (availability == NFCAvailability.available) {
  //       final tag = await FlutterNfcKit.poll();
  //       setState(() {
  //         _nfcData = tag.ndefMessage?.map((e) => e.payload).join(", ") ?? "No NDEF Data";
  //       });
  //       await FlutterNfcKit.finish();
  //     } else {
  //       setState(() {
  //         _nfcData = "NFC is not available.";
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _nfcData = "Error: $e";
  //     });
  //   }
  // }

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
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
