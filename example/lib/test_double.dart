import 'package:dbpage_routing/dbpage_routing.dart';

part 'test_double.g.dart';

@TestAnnotation("class")
class TestDouble {
  @TestAnnotation(100.345345)
  final double someField;

  TestDouble(this.someField);
}