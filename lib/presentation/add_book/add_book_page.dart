import 'package:corianderapp/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage(
      {this.book}); //イニシャライザ　this.bookを{}で囲まないと引数にthis.bookをいれることが強制ではなくなる。引数有無で挙動を変える(5:00 Firestoreの値を)
  final Book
      book; //AddBookPage()に値を渡すための定義(4:38　Firestoreの更新) あれ、Bookクラスはどこで定義してる？→book.dar　importして解決
  @override
  Widget build(BuildContext context) {
    final bool isUpdate = book != null; //bookがnullじゃなければtrue(6:27　Firestoreの更新)
    final textEditingController = TextEditingController();

    if (isUpdate) {
      textEditingController.text = book.title;
    }

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate
              ? '本を編集'
              : '本を追加'), //3項演算子 やっていることはif else分と一緒　1行でかける(7:35　動画：Firestoreの更新)
        ),
        body: Consumer<AddBookModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller:
                        textEditingController, //デフォルトのテキスト（元の本の名前）いれる(10:30　動画：Firestoreの更新)
                    //昔の動画参照
                    onChanged: (text) {
                      //TextFieldの値が変化したら14:30
                      model.bookTitle = text;
                    },
                  ),
                  RaisedButton(
                    child: Text(isUpdate ? '更新する' : '追加する'),
                    onPressed: () async {
                      //TODO: Updateがあれば更新、なければfirestoreに本を追加 14:40
                      if (isUpdate) {
                        await updateBook(model, context);
                      } else {
                        //TODO: 本を追加
                        await addBook(model, context);
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

  //RaisedButtonを押したときの処理が長いのでaddBook()メソッドで分割（Firestore更新　18:54）
  Future addBook(AddBookModel model, BuildContext context) async {
    try {
      //うまくいった場合のことをかく
      await model.addBookToFirebase();
      //15:53 保存したか分からないので、showDialogを追加 使い方をcookbookで調べる
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました！'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop(); //22:49 成功したら元のページに戻る
    } catch (e) {
      //exceptionが発生した場合のことをかく
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
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

  //RaisedButtonを押したときの処理が長いのでaddBook()メソッドで分割（Firestore更新　18:54）
  Future updateBook(AddBookModel model, BuildContext context) async {
    try {
      //うまくいった場合のことをかく
      await model.updateBook(book);
      //15:53 保存したか分からないので、showDialogを追加 使い方をcookbookで調べる
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('更新しました！'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop(); //22:49 成功したら元のページに戻る
    } catch (e) {
      //exceptionが発生した場合のことをかく
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
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
}
