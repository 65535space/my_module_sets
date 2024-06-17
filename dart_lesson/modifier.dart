void main() {
  // const　コンパイル時に値が決まる
  const int a = 1;
  print(a); // 整数型　1
  const String message = "Hello World";
  print(message); // 文字列　Hello World
  // final コンパイル後に値が決まる
  final bool messageIsEmpty = message.isEmpty;
  print(messageIsEmpty); // false
  // var
  var hellowWorldMessage = "Hello World";
  hellowWorldMessage = "こんにちは世界";
  print(hellowWorldMessage); // こんにちは世界
}
