import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationHandlerPage extends StatelessWidget {
  final Map<String, dynamic> args;

  const NotificationHandlerPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = args['title'] ?? 'No Title';
    final String body = args['body'] ?? 'No Body';

    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ],
    );
  }
}
