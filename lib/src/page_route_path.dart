import "package:meta/meta.dart" show literal;

/// Page Route path.
///
/// Contains information about the location of page and his parameters.
class PageRoutePath {
  /// Used to annotated a Widget `a`.
  ///
  /// Indicates the [path] of widget and the [arguments] the widget depends on.
  @literal
  const PageRoutePath(this.path, {this.arguments});

  /// Page's path.
  final String path;

  /// Page's arguments.
  final Map<String, dynamic> arguments;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageRoutePath &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          arguments == other.arguments;

  @override
  int get hashCode => path.hashCode ^ arguments.hashCode;

  @override
  String toString() {
    return "PageRoutePath{path: $path, arguments: $arguments}";
  }
}
