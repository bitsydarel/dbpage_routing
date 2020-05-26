import 'package:dbpage_routing/dbpage_routing.dart';

part 'test_custom_object.g.dart';

@TestAnnotation("class")
class TestCustomObject {
  @TestAnnotation(User("flutter", true))
  final User someField;

  TestCustomObject(this.someField);
}

class User {
  final String name;

  final bool optionalFlag;

  const User(this.name, [this.optionalFlag]);
}
