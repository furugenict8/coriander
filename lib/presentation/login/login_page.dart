import 'package:corianderapp/presentation/login/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ログイン'),
        ),
        body: Consumer<LoginModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'example@kboy.com'), //　薄い字でhintをいれる
                    controller: mailController,
                    onChanged: (text) {
                      model.mail = text;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'password'),
                    controller: passwordController,
                    obscureText:
                        true, // 文字を伏字にする　（動画　Firebase Authで新規登録やログインを実装する9:50くらい）
                    onChanged: (text) {
                      model.password = text;
                    },
                  ),
                  ElevatedButton(
                    child: Text('ログインする'),
                    onPressed: () async {
                      try {
                        await model.login();
                        _showDialog(context, 'ログインしました。');
                      } catch (e) {
                        _showDialog(context, e.toString());
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  //book_list_pageから以下コピペ。本当はどこかにまとめておいた方がいいらしい。(FirebaseAuth14:10)
  Future _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
