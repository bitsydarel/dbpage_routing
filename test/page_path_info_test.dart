import "package:dbpage_routing/dbpage_routing.dart";
import "package:test/test.dart";

void main() {
  group(
    "verify if page route info can properly be created different path formats",
    () {
      test(
        "should return page builder with all the data for path format",
        () {
          final pathOnlyBuilder = PagePathInfo.from(
            "/posts",
          );

          expect(pathOnlyBuilder.metadata.root, "/posts");

          expect(pathOnlyBuilder.metadata.segments, isNull);

          expect(pathOnlyBuilder.metadata.arguments, isNull);
        },
      );

      test(
        "should return page route info for path with sub-paths",
        () {
          final pathOnlyBuilderWithSubPaths = PagePathInfo.from(
            "/posts/postId=int/comments",
          );

          expect(
            pathOnlyBuilderWithSubPaths.metadata.root,
            equals("/posts"),
          );

          expect(pathOnlyBuilderWithSubPaths.metadata.arguments, isNull);

          expect(pathOnlyBuilderWithSubPaths.metadata.segments, hasLength(2));

          expect(
            pathOnlyBuilderWithSubPaths.metadata.segments[0],
            equals(const PagePathSegmentMetadata(0, "postId", int, false)),
          );

          expect(
            pathOnlyBuilderWithSubPaths.metadata.segments[1],
            equals(const PagePathSegmentMetadata(1, "comments", String, true)),
          );
        },
      );

      test(
        "should return page route info for path with queries",
        () {
          final pathWithQueryBuilder = PagePathInfo.from(
            "https://google.com?country=String&postCode=int&city=String",
          );

          expect(
            pathWithQueryBuilder.metadata.root,
            equals("https://google.com"),
          );

          expect(pathWithQueryBuilder.metadata.segments, isNull);

          expect(
            pathWithQueryBuilder.metadata.arguments,
            hasLength(3),
          );

          expect(
            pathWithQueryBuilder.metadata.arguments,
            containsAll(
              <PagePathArgumentMetadata>[
                const PagePathArgumentMetadata("country", "String"),
                const PagePathArgumentMetadata("postCode", "int"),
                const PagePathArgumentMetadata("city", "String")
              ],
            ),
          );
        },
      );
    },
  );

  test(
    "should return the root for unknown uri",
    () {
      expect(
        PagePathInfo.getRootForUnknownUri(Uri.tryParse("/posts")),
        equals("/posts"),
      );

      expect(
        PagePathInfo.getRootForUnknownUri(Uri.tryParse("/posts/1234")),
        equals("/posts"),
      );

      expect(
        PagePathInfo.getRootForUnknownUri(Uri.tryParse("/users?userId=134")),
        equals("/users"),
      );

      expect(
        PagePathInfo.getRootForUnknownUri(Uri.tryParse("/users/1234/posts/12")),
        equals("/users"),
      );
    },
  );

  test(
    "should return typed segment metadata if passed valid segment with type",
    () {
      final segmentMetaData = PagePathInfo.parsePathSegment(
        0,
        "userId=int",
      );

      expect(segmentMetaData.index, equals(0));

      expect(segmentMetaData.name, equals("userId"));

      expect(segmentMetaData.type, equals(int));
    },
  );

  test(
    "should return segment metadata if passed valid segment",
    () {
      final segmentMetadata = PagePathInfo.parsePathSegment(1, "postId");

      expect(segmentMetadata, isA<PagePathSegmentMetadata>());

      expect(segmentMetadata.index, equals(1));

      expect(segmentMetadata.name, equals("postId"));
    },
  );

  test(
    "should return null if could not parse segment",
    () {
      expect(
        PagePathInfo.parsePathSegment(-1, ""),
        isNull,
      );

      expect(
        PagePathInfo.parsePathSegment(4, "some=some=some"),
        isNull,
      );

      expect(
        PagePathInfo.parsePathSegment(2, "here="),
        isNull,
      );
    },
  );
}
