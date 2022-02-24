import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
        child: Center(
          child: ElevatedButton(
            child: Text('web'),
            onPressed: () async {
              final url = 'https://translate.google.jo';
              if (await canLaunch(url)) {
                await launch(
                    url,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

