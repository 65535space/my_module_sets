class Car {
  String country;

  Car(this.country);
}

class JapaneseCar extends Car {
  JapaneseCar(String country) : super(country);
}

class AmericanCar extends Car {
  AmericanCar(String country) : super(country);
}

void main() {
  String country = "USA";
  late Car car;
  switch (country) {
    case "Japanese":
      car = JapaneseCar(country);
      break;
    case "USA":
      car = AmericanCar(country);
      break;
    default:
      car = Car(country);
      break;
  }
  print("型: ${car.runtimeType}");
}
