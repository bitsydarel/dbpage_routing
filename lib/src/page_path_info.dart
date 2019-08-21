import "package:dbpage_routing/dbpage_routing.dart";
import "package:dbpage_routing/src/invalid_page_path_error.dart";
import "package:dbpage_routing/src/page_path_metada.dart";
import "package:meta/meta.dart" show visibleForTesting;

class PagePathInfo {
  const PagePathInfo(this.metadata);

  factory PagePathInfo.from(
    final String path,
  ) {
    if (path == null && path.isEmpty && path.contains("/")) {
      return null;
    } else {
      final url = Uri.tryParse(path);

      if (url == null) {
        throw InvalidPagePathError(
          "Invalid page route path provided",
          suggestions:
              "check the documentation for a valid page route path format",
        );
      }

      final root = url.hasScheme ? url.origin : getRootForUnknownUri(url);

      final subPaths = _filterSubPath(root, url.pathSegments);

      final segments =
          subPaths.isNotEmpty ? parseRouteSegments(subPaths) : null;

      final queries = url.queryParameters.isNotEmpty
          ? parsePathQueries(url.queryParameters)
          : null;

      return PagePathInfo(
        PagePathMetadata(
          root,
          segments: segments,
          arguments: queries,
        ),
      );
    }
  }

  final PagePathMetadata metadata;

  @visibleForTesting
  static List<PagePathSegmentMetadata> parseRouteSegments(
    final List<String> segments,
  ) {
    final result = <PagePathSegmentMetadata>[];

    for (var index = 0; index < segments.length; index++) {
      final segment = segments[index];

      final segmentMetadata = parsePathSegment(index, segment);

      if (segmentMetadata == null) {
        throw InvalidPagePathError(
          "Invalid segment: $segment founded in the page route",
          suggestions:
              "segment have two formats ex: /userId or typed: /userId=int",
        );
      } else {
        result.add(segmentMetadata);
      }
    }

    return result;
  }

  @visibleForTesting
  static List<PagePathArgumentMetadata> parsePathQueries(
    Map<String, String> queryParameters,
  ) {
    return queryParameters.entries
        .map(
          (entry) => PagePathArgumentMetadata(entry.key, entry.value),
        )
        .toList();
  }

  @visibleForTesting
  static PagePathSegmentMetadata parsePathSegment(
    final int index,
    final String segment,
  ) {
    final segmentPart = segment.split("=")
      ..retainWhere((part) => part.isNotEmpty);

    if (segmentPart.length == 2) {
      final segmentName = segmentPart[0];
      final segmentType = segmentPart[1];
      return PagePathSegmentMetadata(
        index,
        segmentName,
        _resolveSegmentType(segmentName, segmentType),
        false,
      );
    } else if (segmentPart.length == 1 && !segment.contains("=")) {
      return PagePathSegmentMetadata(
        index,
        segmentPart[0],
        String,
        true,
      );
    } else {
      return null;
    }
  }

  @visibleForTesting
  static String getRootForUnknownUri(final Uri unknownUrl) {
    // We get the index of the first '/' after the root one.
    // So that we will know if there's any sub path.
    // We start at index one because we need to skip any root '/'.
    final subPathStartIndex = unknownUrl.path.substring(1).indexOf("/");

    if (subPathStartIndex > 0) {
      // The root path should be the beginning of the path
      // to the index of the first upcoming '/'.
      return unknownUrl.path.substring(0, subPathStartIndex + 1);
    } else {
      return "/${unknownUrl.pathSegments[0]}";
    }
  }

  static List<String> _filterSubPath(
    final String root,
    final List<String> subPaths,
  ) {
    return subPaths.isNotEmpty && subPaths[0] == root.substring(1)
        ? subPaths.sublist(1)
        : subPaths;
  }

  static Type _resolveSegmentType(final String name, final String type) {
    if (type == "int") {
      return int;
    } else if (type == "String") {
      return String;
    } else {
      throw InvalidPagePathError("invalid segment type specified for $name",
          suggestions: "allowed segment type are int and String");
    }
  }
}
