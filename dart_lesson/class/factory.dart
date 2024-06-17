class Car {
  String country = "";

  Car(this.country);

  factory Car.fromCountry(String country) {
    switch (country) {
      case "Japanese":
        return JapaneseCar();
      case "USA":
        return AmericanCar();
      default:
        return Car(country);
    }
  }
}

class JapaneseCar extends Car {
  JapaneseCar() : super("Japanese");
}

class AmericanCar extends Car {
  AmericanCar() : super("USA");
}

void main() {
  Car car1 = Car.fromCountry("Japanese");
  print("生産国: ${car1.country}"); // 出力結果: Japanese

  Car car2 = Car.fromCountry("USA");
  print("生産国: ${car2.country}"); // 出力結果: USA

  Car car3 = Car.fromCountry("Germany");
  print("生産国: ${car3.country}"); // 出力結果: Germany
}
