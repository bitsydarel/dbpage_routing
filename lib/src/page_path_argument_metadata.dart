import "package:dbpage_routing/dbpage_routing.dart";

class PagePathArgumentMetadata {
  @literal
  const PagePathArgumentMetadata(this.name, this.type)
      : assert(name != null, "name parameter can't be null"),
        assert(type != null, "type parameter can't be null");

  final String name;

  final String type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PagePathArgumentMetadata &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              type == other.type;

  @override
  int get hashCode =>
      name.hashCode ^
      type.hashCode;

  @override
  String toString() => "PagePathArgumentMetadata{name: $name, type: $type}";
}
