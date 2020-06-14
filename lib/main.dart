import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
//StatelessWidget　状態を変えられないwidget


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('コリアンダー'),
          ),
          body: Center(
            child: Column(
              children: [
                Text(
                  'kboyText',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                RaisedButton(
                  child: Text('ボタン'),
                )
              ],
            ),
          ),
        ),
    );
  }
}


