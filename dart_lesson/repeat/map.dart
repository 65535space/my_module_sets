void main() {
  List<int> numbers = [1, 2, 3, 4, 5];

  List<int> doubleNumbers = numbers.map((number) => number * 2).toList();
  print(doubleNumbers); //出力結果: [2,4,6,8,10]
}
