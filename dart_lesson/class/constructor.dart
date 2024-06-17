class Person {
  String name;
  int age;

  //コンストラクタ
  Person(this.name, this.age);

  void greeting() {
    print("こんにちは、私は$nameです。年齢は$age歳です。");
  }
}

void main() {
  final Person person = Person("勇者ジョン", 16);
  person.greeting(); //出力結果:こんにちは、私は勇者ジョンです。年齢は16歳です。
}
