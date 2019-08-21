import "package:meta/meta.dart" show literal;

class PagePathSegmentMetadata {
  @literal
  const PagePathSegmentMetadata(
    this.index,
    this.name,
    this.type,
    this.isConstant,
  )   : assert(index != null, "index parameter can't be null"),
        assert(name != null, "name parameter can't be null"),
        assert(type != null, "type parameter can't be null"),
        assert(isConstant != null, "isConstant parameter can't be bull");

  final String name;

  final int index;

  final Type type;

  final bool isConstant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagePathSegmentMetadata &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          index == other.index &&
          type == other.type &&
          isConstant == other.isConstant;

  @override
  int get hashCode =>
      name.hashCode ^ index.hashCode ^ type.hashCode ^ isConstant.hashCode;

  @override
  String toString() =>
      "PagePathSegmentMetadata{name: $name, index: $index, type: $type, isConstant: $isConstant}";
}
