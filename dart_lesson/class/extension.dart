extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

void main() {
  String str = "hello world";
  print(str.capitalize()); // "Hello world"
}
