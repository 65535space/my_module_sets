void main() {
  List<String> fruits = ["apple", "banana", "orange"];
  int i = 0;
  // 配列を使用したfor文
  for (final String fruit in fruits) {
    /*
    出力結果:
    apple
    banana
    orange
    */
    print(i);
    i++;
    print(fruit);
  }

  // iを使用したい場合
  for (int i = 0; i < fruits.length; i++) {
    /*
    出力結果
    0 : apple
    1 : banana
    2 : orange
    */
    print("$i : ${fruits[i]}");
  }
}
