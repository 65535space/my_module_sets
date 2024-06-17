void main() {
  int i = 0;
  String? password;
  do {
    print("パスワードを入力してください:");
    password = 'test'; // ここでは仮に"test"を正しいパスワードとしています
    print(i);
  } while (password != "test");

  print("ログインに成功しました。");
}
