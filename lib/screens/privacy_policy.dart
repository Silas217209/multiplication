import 'package:flutter/material.dart';
import 'package:multiplication/utils/variablen.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(translation.statistikenlabel),
      actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, '/einstellungen'),
            icon: Icon(Icons.settings)
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(translation.policy),
      )
    );
  }
}
