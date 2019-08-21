import "package:code_builder/code_builder.dart";
import "package:dbpage_routing/dbpage_routing.dart";
import "package:dbpage_routing_generator/src/page_metadata_builder.dart";

class PageRouteBuilder {
  const PageRouteBuilder(this.pagePathInfo);

  final PagePathInfo pagePathInfo;

  String build() {
    final formatter = DartEmitter();

    final pagePathMetadataField = generatePagePathMetadataField(pagePathInfo);

    final matchPathMethod = generateMatchPageRouteMethod(pagePathInfo);

    final output = StringBuffer()
      ..writeln(pagePathMetadataField.accept(formatter).toString())
      ..writeln()
      ..writeln()
      ..writeln(matchPathMethod.accept(formatter).toString())
      ..writeln();

    return output.toString();
  }

  @visibleForTesting
  static Field generatePagePathMetadataField(PagePathInfo pageRouteInfo) {
    final metadataField = FieldBuilder()
      ..name = "_metadata"
      ..type = refer("PagePathMetadata")
      ..modifier = FieldModifier.constant
      ..assignment = Code(
        """
        PagePathMetadata(
          "${pageRouteInfo.metadata.root}",
          segments: ${generateSegmentsCode(pageRouteInfo.metadata.segments)},
          arguments: ${generateArgumentsCode(pageRouteInfo.metadata.arguments)},
        )""",
      );

    return metadataField.build();
  }

  @visibleForTesting
  static Method generateMatchPageRouteMethod(PagePathInfo pageRouteInfo) {
    final segmentBuilder = SegmentMetadataCodeBuilder(
      segments: pageRouteInfo.metadata.segments,
    );

    final matchMethodBody = StringBuffer()
      ..writeln("try {")
      ..writeln(
        """
        final otherPagePathMetadata = PagePathInfo.from(path).metadata;
          
        if (_metadata.root != otherPagePathMetadata.root) {
          return false;
        }
        
        if (_metadata.segments == null && otherPagePathMetadata.segments != null) {
          return false;
        }
        
        if (_metadata.segments != null && otherPagePathMetadata.segments == null) {
          return false;
        }
        
        if (_metadata.segments.length != otherPagePathMetadata.segments.length) {
          return false;
        }
       """,
      )
      ..writeln(
        """
        for (var index = 0; index < _metadata.segments.length; index++) {
        """,
      )
      ..writeln(
        segmentBuilder.buildMatchCode(),
      )
      ..writeln("}")
      ..writeln("}")
      ..writeln(
        """
        on InvalidPagePathError catch (_) {
          return false;
        }
        """,
      )
      ..writeln()
      ..writeln("return true;");

    final matchMethod = MethodBuilder()
      ..name = "\$matchRoute"
      ..requiredParameters.add(
        Parameter(
          (configuration) => configuration
            ..name = "path"
            ..type = refer("String"),
        ),
      )
      ..returns = refer("bool")
      ..body = Code(matchMethodBody.toString());

    return matchMethod.build();
  }

  @visibleForTesting
  static String generateSegmentsCode(
    final List<PagePathSegmentMetadata> segments,
  ) {
    return SegmentMetadataCodeBuilder(segments: segments)
        .buildConstructionCode();
  }

  @visibleForTesting
  static String generateArgumentsCode(
    final List<PagePathArgumentMetadata> arguments,
  ) {
    return ArgumentMetadataCodeBuilder(arguments: arguments)
        .buildConstructionCode();
  }
}
