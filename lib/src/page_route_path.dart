import "package:meta/meta.dart" show literal;

/// Page Route path.
///
/// Contains information about the location of page and his parameters.
class PageRoutePath {
  /// Used to annotated a Widget `X`.
  ///
  /// Indicates the [path] of widget and the [arguments] the widget depends on.
  ///
  /// The [path] to required to access tbe widget, example:
  /// "/randomPath"
  ///
  /// The [path] would contains the [arguments] name in it, example:
  /// "/somePath?argument1?argument2"
  ///
  /// The [arguments] map has key as argument's name and value as it's type:
  ///
  /// {"argument1": String, "argument2": String}
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
