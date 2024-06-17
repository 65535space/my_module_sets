void main() async {
  print("main関数が始まりました");
  await Future.wait([asyncFunction1(), asyncFunction2()]);
  print("main関数が終了しました");
  /*
  プログラムを開始します
  非同期処理1を開始します
  非同期処理1が完了しました
  非同期処理2を開始します
  非同期処理2が完了しました
  プログラムを終了します
  */
}

// 3秒待機する非同期関数
Future<void> asyncFunction1() async {
  print("非同期処理1を開始します");
  const duration = Duration(seconds: 3);
  await Future.delayed(duration);
  print("非同期処理1が完了しました");
}

//2秒待機する非同期関数
Future<void> asyncFunction2() async {
  print("非同期処理2を開始します");
  const duration = Duration(seconds: 2);
  await Future.delayed(duration);
  print("非同期処理2が完了しました");
}
