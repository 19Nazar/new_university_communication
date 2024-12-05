import 'dart:io';

import 'package:flutter/foundation.dart';
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

  Future<bool>? suportNFC;

  Future<List<dynamic>>? infoScan;

  Service service = Service();

  @override
  void initState() {
    super.initState();
    final isSuport = service.isNfCAvailable();
    suportNFC = isSuport;
  }

  Future<void> scanNFC() async {
    final res = await service.scanNFC();
    setState(() {
      infoScan = Future.value(res);
    });
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
            suportNFC == null
                ? Container()
                : FutureBuilder<bool>(
                    future: suportNFC,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return SelectableText('Error: ${snapshot.error}');
                      } else {
                        return Center(
                            child: Text(
                          '${snapshot.data.toString()}',
                          style: Thems.textStyle,
                        ));
                      }
                    },
                  ),
            CustomButton(onPressed: (() {}), text: "Student card ID number"),
            SizedBox(height: 10),
            CustomButton(
                onPressed: (() async {
                  await scanNFC();
                }),
                text: "Scan student card"),
            SizedBox(height: 10),
            infoScan != null
                ? FutureBuilder<List<dynamic>>(
                    future: infoScan,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return SelectableText('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return Column(
                          children: data.map((info) {
                            final res = info as Map<String, dynamic>;
                            return SelectableText(
                                "Type: ${res["type"]}, Data: ${res["data"]}");
                          }).toList(),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'No data available',
                            style: Thems.textStyle,
                          ),
                        );
                      }
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
