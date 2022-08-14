import 'package:flutter/material.dart';

class HomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ButtonTheme(
          minWidth: 150,
          height: 200,
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            child: const Text('早口言葉レベル1'),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[300],
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/play/basic");
            },
          ),
        ),
        ButtonTheme(
          minWidth: 150,
          height: 200,
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            child: const Text('早口言葉レベル2'),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[300],
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/play/advanced");
            },
          ),
        ),
      ],
    );
  }
}
