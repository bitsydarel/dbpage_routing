// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// DBPageRoutingGenerator
// **************************************************************************

const PagePathMetadata _metadata = PagePathMetadata(
  "https://mywebsite.com",
  segments: null,
  arguments: null,
);

bool $matchRoute(String path) {
  try {
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

    for (var index = 0; index < _metadata.segments.length; index++) {
      final segment = _metadata.segments[index];
      final otherSegment = otherPagePathMetadata.segments[index];

      if (segment.index != otherSegment.index) {
        return false;
      }

      if (segment.type == int && int.tryParse(otherSegment.name) == null) {
        return false;
      } else if (segment.isConstant && segment.name != otherSegment.name) {
        return false;
      }
    }
  } on InvalidPagePathError catch (_) {
    return false;
  }

  return true;
}
