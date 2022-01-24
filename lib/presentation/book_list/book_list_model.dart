//概念的に言うとドメインモデルという。通信とか ビジネスロジック的なことを 8:26
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corianderapp/domain/book.dart';
import 'package:flutter/cupertino.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  //通信を伴うので時間がかるそのために await もしくは上記サイトの　then〜をつける。javascriptでよくある。
  //Firestore 〜 get()は　https://pub.dev/packages/cloud_firestore Get a stacific document から　コピー
  Future fetchBooks() async {
    final docs = await FirebaseFirestore.instance.collection('books').get();
    final books = docs.docs
        .map((doc) => Book(doc))
        .toList(); // map()　はリストの中を全部変換できる。13:19
    this.books = books; //リストのbooks に　変数のbooksをいれる❔　14:43
    notifyListeners(); //上記処理の後にお知らせする。　15:10
  }

  //削除メソッド　(Firestore delete 6:58)
  Future deleteBook(Book book) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc(book.documentID)
        .delete();
  }
}
