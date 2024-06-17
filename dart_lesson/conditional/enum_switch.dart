void main() {
  Season season = Season.spring;

  switch (season) {
    case Season.spring:
      print("春です。");
      break;
    case Season.summer:
      print("夏です。");
      break;
    case Season.autumn:
      print("秋です。");
      break;
    case Season.winter:
      print("冬です。");
      break;
  }
}

enum Season { spring, summer, autumn, winter }
