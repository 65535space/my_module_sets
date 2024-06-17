void main() async {
  // 3秒待機する非同期関数
  Future<void> asyncFunction1() async {
    print("非同期処理1を開始します");
    await Future.delayed(Duration(seconds: 3));
    print("非同期処理1が完了しました");
  }

  //2秒待機する非同期関数
  Future<void> asyncFunction2() async {
    print("非同期処理2を開始します");
    await Future.delayed(Duration(seconds: 2));
    print("非同期処理2が完了しました");
  }

  print("プログラムを開始します");
  asyncFunction1();
  asyncFunction2();
  print("プログラムを終了します");
}
/*
正
プログラムを開始します
非同期処理1を開始します
非同期処理1が完了しました
非同期処理2を開始します
非同期処理2が完了しました
プログラムを終了します

負
プログラムを開始します
非同期処理1を開始します
非同期処理1が完了しました
非同期処理2を開始します
非同期処理2が完了しました
プログラムを終了します
*/