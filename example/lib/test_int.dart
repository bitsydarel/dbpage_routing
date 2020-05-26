import 'package:dbpage_routing/dbpage_routing.dart';

part 'test_int.g.dart';

@TestAnnotation("class")
class TestInt {
  @TestAnnotation(50)
  final int someField;

  TestInt(this.someField);
}
