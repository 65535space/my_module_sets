class Person {
  String name = "勇者ジョン";
  int age = 16;

  void greeting() {
    print("こんにちは、私は$nameです。年齢は$age歳です。");
  }

  void main() {
    final Person person = Person();
    person.greeting(); // 出力結果:こんにちは、私は勇者ジョンです。年齢は16歳です。
  }
}
