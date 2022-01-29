// [Flutter/Dartにおけるimmutableの実践的な扱い方 | by mono  | Flutter 🇯🇵 | Medium](https://medium.com/flutter-jp/immutable-d23bae5c29f8)

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// @immutableアノテーション付ける
@immutable
class Immutable2 {
  // 全てのフィールドがfinalだと生成後に不変であることが保証されるのでconstにできる。
  // (@immutableにより、constを付けないと警告がでて指定漏れを教えてくれる)
  const Immutable2(this.value);
  // finalが欠けるとimmutableとして成り立たないのでコンパイルエラー
  final int value;
}

void main() {
  test('immutable2', () {
    var x1 = Immutable2(1);
    // 参照渡しなので、x2とx1は同じ実体を参照している。
    final x2 = x1;
    // immutable2()はconstコンストラクタで、fieldは全てfinalになってる。
    // そのため変更不可能(=immutable)
    // x1.value++;

    // immutableなオブジェクトは変更操作ができず
    // 違う値を持たせたい場合は再生成が必要
    x1 = Immutable2(x1.value + 1);
    expect(x1.value, 2);
    // x1を変更したわけではなく再生成したのでx2のvalueは元のまま
    expect(x2.value, 1);
    // 参照も違う
    expect(identical(x1, x2), isFalse);
  });

  // constとfinalの違い。
  test('immutable const', () {
    final x1 = Immutable2(1);
    final x2 = Immutable2(1);
    //　参照先が違う
    expect(identical(x1, x2), isFalse);
    const x3 = Immutable2(1);
    const x4 = Immutable2(1);
    // 変数にconstがついているので、参照先が同じ
    expect(identical(x3, x4), isTrue);
  });

  // constの明示の必要性
  test('const list', () {
    final x1 = <int>[];
    // なんでfinalだと入れられるのかよくわからん。
    x1.add(1);
    // Unsupported operation: Cannot add to an unmodifiable list
    // 上記エラーでテスト失敗する。
    const x2 = <int>[];
    x2.add(1);
  });
}
