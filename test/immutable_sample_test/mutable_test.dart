// 参照：[Flutter/Dartにおけるimmutableの実践的な扱い方 | by mono  | Flutter 🇯🇵 | Medium](https://medium.com/flutter-jp/immutable-d23bae5c29f8)
import 'package:flutter_test/flutter_test.dart';

class Mutable {
  Mutable(this.value);
  int value;
}

void main() {
  test('mutable', () {
    final x1 = Mutable(1);
    //　参照渡し
    final x2 = x1;
    x1.value++;
    expect(x1.value, 2);
    // x2とx1の参照先は同一なのでx1のvalueが変更されるとm2も変更される
    expect(x2.value, 2);
    expect(x1 == x2, isTrue);
    //　オブジェクトが持っているhashcodeも同じ。
    expect(identical(x1, x2), isTrue);
  });
}
