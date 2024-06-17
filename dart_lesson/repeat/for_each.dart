void main() {
  List<String> fruits = ["apple", "banana", "orange"];
  /*
  出力結果:
  apple
  banana
  orange
  */
  fruits.forEach((fruit) {
    print(fruit);
  });
  int i = 0;
  /*
  出力結果
  0 : apple
  1 : banana
  2 : orange
  */
  fruits.forEach((fruit) {
    print("$i : $fruit");
    i++;
  });
}
