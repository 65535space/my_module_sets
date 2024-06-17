mixin HelloMixin {
  final String helloMsg = "Hello";
  void hello() => print("こんにちは");
}

mixin GoodByeMixin {
  final String goodbyeMsg = "Goodbye";
  void goodbye() => print("さようなら!");
}

class Person with HelloMixin, GoodByeMixin {
  String name;
  Person(this.name);

  void greeting() {
    hello();
    print(helloMsg);
    print("私の名前は$nameです。");
    print(goodbyeMsg);
    goodbye();
  }
}

void main() {
  final Person person = Person("アリス");
  /*
  出力結果:
  こんにちは
  Hello
  私の名前はアリスです
  Goodbye
  さようなら！
  */
  person.greeting();
  print("${person.helloMsg} ${person.goodbyeMsg}"); //// 出力結果: Hello Goodbye
}
