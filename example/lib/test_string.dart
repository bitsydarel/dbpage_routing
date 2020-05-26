import 'package:dbpage_routing/dbpage_routing.dart';

part 'test_string.g.dart';

@TestAnnotation("class")
class TestString {
  @TestAnnotation("seva is big like flutter")
  final String someField;

  TestString(this.someField);
}
