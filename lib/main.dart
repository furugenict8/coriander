import 'package:corianderapp/main_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
//StatelessWidget　状態を変えられないwidget


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider<MainModel>(
          create: (_) => MainModel(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('コリアンダー'),
            ),
            body: Consumer<MainModel>(
              builder: (context, model, child) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        model.kboyText,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      RaisedButton(
                        child: Text('ボタン'),
                        onPressed: (){//RaisedButtonを押した時に
                          //こ子で何か
                          model.changeKboyText();//Consumerの中のbuilderのmodel(今回はMainModelのこと)
                        },
                      )
                    ],
                  ),
                );
              }
            ),
          ),
        ),
    );
  }
}


