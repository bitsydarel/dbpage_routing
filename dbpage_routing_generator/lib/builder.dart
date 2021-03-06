import "package:build/build.dart" show Builder, BuilderOptions;
import "package:dbpage_routing_generator/src/dbpage_routing_generator.dart";
import 'package:dbpage_routing_generator/src/test_annotation_generator.dart';
import "package:source_gen/source_gen.dart";

Builder pageRoutingBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    const [
      DBPageRoutingGenerator(),
      TestAnnotationGenerator(),
    ],
    "dbpage_routing_generator",
  );
}
