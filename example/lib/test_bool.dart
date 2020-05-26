import 'package:dbpage_routing/dbpage_routing.dart';

part 'test_bool.g.dart';

@TestAnnotation("class")
class TestBool {
  @TestAnnotation(true)
  final bool someField;

  TestBool(this.someField);
}
