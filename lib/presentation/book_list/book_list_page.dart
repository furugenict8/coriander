import 'package:corianderapp/domain/book.dart';
import 'package:corianderapp/presentation/add_book/add_book_page.dart';
import 'package:corianderapp/presentation/book_list/book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      // BookListModelのfetchBooks()を作る。
      create: (_) => BookListModel()..fetchBooks(), //15:42,
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            //createで作られたmodelのnotifyListeners()が飛ぶとここの値が更新される　16:00
            final books = model.books; // book_list_model.dartのbooks 16:16
            final listTiles = books //わかりやすくするため変数を変更。
                .map(
                  (book) => ListTile(
                    //firebase strage 画像　4:40 リストの左に画像を表示させる
                    leading: Image.network(
                        'https://64.media.tumblr.com/tumblr_md2bp8iPEb1rjbk13o1_1280.png'),
                    //mapは型を変換するメソッド　19:55
                    title: Text(book.title),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        //Todo :画面遷移
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBookPage(
                              book: book,
                            ), //add_book_page に何も渡さなければ、新規追加、オブジェクトが渡されたら更新　4:08　Firestoreの更新
                            fullscreenDialog: true,
                          ),
                        );
                        model.fetchBooks();
                      },
                    ),
                    onLongPress: () async {
                      //todo:削除
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                '${book.title}を削除しますか？'), //${}は変数を参照できる。（5:43　Firestore delete　）
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () async {
                                  Navigator.of(context).pop();

                                  //Todo:削除のAPIを叩く
                                  await deleteBook(context, model, book);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }, //長押ししたら削除(1:45 Firestore delete)
                  ),
                )
                .toList(); // 16:50
            return ListView(
              children: listTiles,
            );
          },
        ),
        //23:51 追加されたらbook_list_pageを更新したい
        floatingActionButton:
            // model.fetchBooks()を使いたいので、ConsumerでFloatingActionButtonを囲んでおく。
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              //Todo
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              // await Navigator.push()処理後、つまりadd_book_pageから戻ってきた時に
              // model.fetchBooks()を実行
              // こうすることで、add_book_pageからbook_list_pageに戻ったときに
              // firestoreから最新のデータ(add_book_pageで追加した本も含む)を読み取り、
              // 画面が更新される。
              model.fetchBooks();
            },
          );
        }),
      ),
    );
  }

  //本を長押しするとダイヤログを表示する(2:41 Firestore delete)
  Future deleteBook(
    BuildContext context,
    BookListModel model,
    Book book,
  ) async {
    try {
      await model.deleteBook(book);
      await model.fetchBooks();
    } catch (e) {
      //exceptionが発生した場合のことをかく
      //await _showDialog(context, e.toString());
      //test20200909
      print(e.toString());
    }
  }
}
