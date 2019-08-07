import "package:dbpage_routing/dbpage_routing.dart";

dynamic main() {
  final awesome = const PageRoutePath("/");

  print("awesome without arguments: $awesome");

  final awesomeWithArguments = const PageRoutePath(
    "/?username?password",
    arguments: {"username": String, "password": String},
  );

  print("awesome with arguments: $awesomeWithArguments");
}
