void main() {
  bool a = true;
  bool b = false;
  bool c = true;

  // && かつ
  print(a && c); //出力結果: true
  // ignore: dead_code
  print(b && c); //出力結果: false

  // 否定
  print(!a); // 出力結果: false
  print(!b); // 出力結果: true

  // == 等しい
  print(a == b); // 出力結果: false
  print(a == c); // 出力結果: true

  // != 等しくない
  print(a != b); // 出力結果: true
  print(a != c); // 出力結果: false
}
