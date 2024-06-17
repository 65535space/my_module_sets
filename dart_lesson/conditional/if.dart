void main() {
  bool isRaining = true; // 雨が降っているかどうかを表す関数

  if (isRaining) {
    // 雨が降っている場合
    print("傘を持っていきましょう。");
    // ignore: dead_code
  } else {
    // 雨が降っていない場合
    print("傘は必要ありません。");
  }

  bool hasMoney = false; //お金があるかどうかを表す関数

  if (!hasMoney) {
    // お金がない場合
    print("今日は家で過ごしましょう。");
    // ignore: dead_code
  } else {
    // お金がある場合
    print("お出かけしてもいいかもしれませんね。");
  }
  bool hasCoffee = true; // コーヒーがあるかどうかを表す変数
  bool hasMilk = false; // ミルクがあるかどうかを表す変数

  // ignore: dead_code
  if (hasCoffee && hasMilk) {
    // コーヒーとミルクがある場合
    print("コーヒーにミルクを入れました。");
  } else if (hasCoffee && !hasMilk) {
    // コーヒーがあって、ミルクがない場合
    print("コーヒーをブラックで飲みます。");
    // ignore: dead_code
  } else {
    // コーヒーもミルクもない場合
    print("コーヒーがない！まずい、まだ寝たい...");
  }

  bool isSunny = true; // 天気が晴れかどうかを表す変数
  bool isWarm = true; // 暖かいかどうかを表す変数

  // ignore: dead_code
  if (isSunny || isWarm) {
    // 天気が晴れであるか、または暖かい場合
    print("外で過ごすには最高の日です！");
    // ignore: dead_code
  } else {
    // 天気が曇りや雨で、かつ寒い場合
    print("家でまったりするのも悪くないかも。");
  }

  int number = 10;

  if (number > 0) {
    print("numberは0より大きいです。");
  } else if (number < 0) {
    print("numberは0より小さいです。");
  } else {
    print("numberは0です。");
  }
}
