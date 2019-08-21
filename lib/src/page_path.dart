import "package:meta/meta.dart" show literal;

/// Page Route path.
///
/// Contains information about the location of page and his parameters.
class PagePath {
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
  const PagePath(this.path)
      : assert(path != null, "path parameter can't be null");

  /// Page's path.
  final String path;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagePath &&
          runtimeType == other.runtimeType &&
          path == other.path;

  @override
  int get hashCode => path.hashCode;

  @override
  String toString() => "PageRoutePath{path: $path}";
}
