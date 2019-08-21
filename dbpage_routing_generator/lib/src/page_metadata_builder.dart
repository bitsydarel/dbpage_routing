import "package:dbpage_routing/dbpage_routing.dart";

abstract class PageMetadataBuilder {
  String buildConstructionCode();

  String buildMatchCode();
}

class SegmentMetadataCodeBuilder extends PageMetadataBuilder {
  SegmentMetadataCodeBuilder({this.segments});

  final List<PagePathSegmentMetadata> segments;

  @override
  String buildConstructionCode() {
    if (segments == null) {
      return "null";
    } else {
      final output = StringBuffer();

      output.writeln("<PagePathSegmentMetadata>[");

      for (var index = 0; index < segments.length; index++) {
        final segment = segments[index];

        output.writeln(
          """
            PagePathSegmentMetadata(
              ${segment.index}, 
              "${segment.name}", 
              ${segment.type}, 
              ${segment.isConstant},
            ),
            """,
        );
      }

      output.writeln("]");

      return output.toString();
    }
  }

  @override
  String buildMatchCode() {
    final matchCode = StringBuffer()
      ..writeln("final segment = _metadata.segments[index];")
      ..writeln("final otherSegment = otherPagePathMetadata.segments[index];")
      ..writeln()
      ..writeln(
        """
        if (segment.index != otherSegment.index) {
          return false;
        }
        """,
      )
      ..writeln(
        """
        if (segment.type == int && int.tryParse(otherSegment.name) == null) {
          return false;
        } else if (segment.isConstant && segment.name != otherSegment.name) {
          return false;
        }
        """,
      );

    return matchCode.toString();
  }


}

class ArgumentMetadataCodeBuilder extends PageMetadataBuilder {
  ArgumentMetadataCodeBuilder({this.arguments});

  final List<PagePathArgumentMetadata> arguments;

  @override
  String buildConstructionCode() {
    if (arguments == null) {
      return null;
    } else {
      final output = StringBuffer();

      output.writeln("<PagePathArgumentMetadata>[");

      for (var index = 0; index < arguments.length; index++) {
        final argument = arguments[index];

        output.writeln(
          """
            PagePathArgumentMetadata(
              "${argument.name}", "${argument.type}"
            ),
            """,
        );
      }

      output.writeln("]");

      return output.toString();
    }
  }

  @override
  String buildMatchCode() {
    // TODO: implement buildMatchCode
    return null;
  }


}
