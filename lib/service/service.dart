import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:new_university_communication/service/js_engines/js_engine_stub.dart'
    if (dart.library.io) 'package:new_university_communication/service/js_engines/implementation/other_fail_engine.dart'
    if (dart.library.js) 'package:new_university_communication/service/js_engines/implementation/web_js_engine.dart';
import 'package:new_university_communication/service/js_engines/js_vm.dart';
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class Service {
  JsVMService jsVMService = getJsVM();

  Service() {}

  Future<bool> isNfCAvailable() async {
    try {
      if (kIsWeb
          ? (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS)
          : (Platform.isAndroid || Platform.isIOS)) {
        final isAvailable = await jsVMService
            .callJS("window.nfcwebinteraction.isNfCSupported()");
        Map<String, dynamic> res = jsonDecode(isAvailable);
        if (res["data"] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<dynamic>> scanNFC() async {
    try {
      final resScan =
          await jsVMService.callJSAsync("window.nfcwebinteraction.readNFC()");
      Map<String, dynamic> res = jsonDecode(resScan);
      if (res.containsKey("error")) {
        throw Exception("Error scan NFC: ${res["error"]}");
      } else {
        return res["data"] as List<dynamic>;
      }
    } catch (error) {
      throw Exception("Error while scan NFC: $error");
    }
  }

  // //for future mobile
  // Future<bool> isNfcAvailable() async {
  //   try {
  //     final availability = await FlutterNfcKit.nfcAvailability;
  //     if (kIsWeb
  //         ? (defaultTargetPlatform == TargetPlatform.android ||
  //             defaultTargetPlatform == TargetPlatform.iOS)
  //         : (Platform.isAndroid || Platform.isIOS)) {
  //       return availability == NFCAvailability.available;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw Exception("Error: $e");
  //   }
  // }

  // //for future mobile
  // Future<void> scanNFC() async {
  //   if (await this.isNfcAvailable() == false) {
  //     throw Exception("You device not support for nfc scan");
  //   }
  //   try {
  //     NFCTag tag = await FlutterNfcKit.poll();
  //     print('Tag found: $tag');
  //     if (tag.ndefAvailable ?? false) {
  //       List<String> futureInfoScan = [];
  //       var records = await FlutterNfcKit.readNDEFRecords();
  //       for (var record in records) {
  //         futureInfoScan.add(record.basicInfoString);
  //         print('Record: $record');
  //       }
  //     } else {
  //       print('NDEF not available for this tag.');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   } finally {
  //     await FlutterNfcKit.finish(iosAlertMessage: "Done!");
  //   }
  // }
}
