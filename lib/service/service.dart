import 'package:new_university_communication/service/crypto/crypto_i.dart';
import 'package:new_university_communication/service/crypto/impl/crypto.dart';

import 'package:new_university_communication/models/models.dart';
import 'package:new_university_communication/service/db_interaction/db_interaction.dart';
import 'package:new_university_communication/service/db_interaction/implement/supabase_db.dart';
import 'package:new_university_communication/service/js_engines/js_engine_stub.dart'
    if (dart.library.io) 'package:new_university_communication/service/js_engines/implementation/other_fail_engine.dart'
    if (dart.library.js) 'package:new_university_communication/service/js_engines/implementation/web_js_engine.dart';
import 'package:new_university_communication/service/js_engines/js_vm.dart';
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class Service {
  late JsVMService jsVMService;
  late DbInteraction dbService;
  late CryptoI crypto;

  Service(
      {required JsVMService jsVMService,
      required DbInteraction dbService,
      required CryptoI crypto}) {
    this.jsVMService = jsVMService;
    this.dbService = dbService;
    this.crypto = crypto;
  }

  factory Service.defaultInstance() {
    return Service(
        jsVMService: getJsVM(),
        dbService: SupabaseDbInteraction.defaultInstance(),
        crypto: Crypto.defaultInstance());
  }

  Future<Map<String, String>> generateRSAKeyPairInIsolate() async {
    return crypto.generateRSAKeyPairInIsolate();
  }

  String privateKeyToString(dynamic privateKey) {
    return crypto.privateKeyToString(privateKey);
  }

  String publicKeyToString(dynamic publicKey) {
    return crypto.publicKeyToString(publicKey);
  }

  String derivePublicKeyFromPrivate(String privateKeyPem) {
    return crypto.derivePublicKeyFromPrivate(privateKeyPem);
  }
  // Future<bool> isNfCAvailable() async {
  //   try {
  //     if (kIsWeb
  //         ? (defaultTargetPlatform == TargetPlatform.android ||
  //             defaultTargetPlatform == TargetPlatform.iOS)
  //         : (Platform.isAndroid || Platform.isIOS)) {
  //       final isAvailable = await jsVMService
  //           .callJS("window.nfcwebinteraction.isNfCSupported()");
  //       Map<String, dynamic> res = jsonDecode(isAvailable);
  //       if (res["data"] == true) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw Exception("Error: $e");
  //   }
  // }

  // Future<List<dynamic>> scanNFC() async {
  //   try {
  //     final resScan =
  //         await jsVMService.callJSAsync("window.nfcwebinteraction.readNFC()");
  //     Map<String, dynamic> res = jsonDecode(resScan);
  //     if (res.containsKey("error")) {
  //       throw Exception("Error scan NFC: ${res["error"]}");
  //     } else {
  //       return res["data"] as List<dynamic>;
  //     }
  //   } catch (error) {
  //     throw Exception("Error while scan NFC: $error");
  //   }
  // }

  Future<DBRespons> createDB(
      {required Map<String, dynamic> data, required String table_name}) async {
    final res = await dbService.create(data: data, table_name: table_name);
    return res;
  }

  Future<DBRespons> readDB({
    Object? filter,
    required String table_name,
    String? select,
    String? filterColumn,
  }) async {
    final res = await dbService.read(
        filter: filter,
        table_name: table_name,
        select: select,
        filterColumn: filterColumn);
    return res;
  }

  Future<DBRespons> updateDB(
      {required String table_name,
      required int id,
      required Map<String, dynamic> data}) async {
    final res =
        await dbService.update(table_name: table_name, id: id, data: data);
    return res;
  }

  Future<DBRespons> delete({
    required int id,
    required String table_name,
  }) async {
    final res = await dbService.delete(id: id, table_name: table_name);
    return res;
  }

  Future<DBRespons> logIn({required String publicKey}) async {
    return await this.readDB(
        table_name: "auth", filterColumn: "public_key", filter: publicKey);
  }

  Future<DBRespons> getTeacherRows({required int id}) async {
    return await this
        .readDB(table_name: "teacher", filterColumn: "id", filter: id);
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
