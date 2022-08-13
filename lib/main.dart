import 'package:flutter/material.dart';
import 'page/home_page.dart';
import 'page/play_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  final String title = 'SPELL BOOK';

  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primaryColor: Colors.blueGrey[600],
        accentColor: Colors.blueGrey[600],
      ),
      home: MyHomePage(title: title),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => MyHomePage(title: title),
        '/play/basic': (BuildContext context) =>
            PlayPage(title: title, level: 'basic'),
        '/play/advanced': (BuildContext context) =>
            PlayPage(title: title, level: 'advanced'),
      },
    );
  }
}
