import "package:analyzer/dart/element/element.dart";
import "package:build/build.dart";
import "package:dbpage_routing_generator/src/page_path_builder.dart";
import "package:source_gen/source_gen.dart";
import "package:dbpage_routing/dbpage_routing.dart";

class DBPageRoutingGenerator extends GeneratorForAnnotation<PagePath> {
  const DBPageRoutingGenerator();

  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is ClassElement) {
      final path = annotation.read("path").stringValue;

      try {
        final pageInfo = PagePathInfo.from(path);

        return PageRouteBuilder(pageInfo).build();

      } on InvalidPagePathError catch (e) {
        throw InvalidGenerationSourceError(
          e.message,
          todo: e.suggestions,
          element: element,
        );
      }
    } else {
      throw InvalidGenerationSourceError(
        "PageRoutePath annotation can only be applied to classes",
        element: element,
      );
    }
  }
}
