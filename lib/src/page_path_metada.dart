import "package:dbpage_routing/src/page_path_argument_metadata.dart";
import "package:dbpage_routing/src/page_path_segment_metadata.dart";
import "package:meta/meta.dart" show literal;

class PagePathMetadata {
  @literal
  const PagePathMetadata(this.root, {this.segments, this.arguments})
      : assert(root != null, "root parameter can't be null");

  final String root;

  final List<PagePathSegmentMetadata> segments;

  final List<PagePathArgumentMetadata> arguments;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagePathMetadata &&
          runtimeType == other.runtimeType &&
          root == other.root &&
          segments == other.segments &&
          arguments == other.arguments;

  @override
  int get hashCode => root.hashCode ^ segments.hashCode ^ arguments.hashCode;

  @override
  String toString() =>
      "PagePathMetadata{root: $root, segments: $segments, arguments: $arguments}";
}
