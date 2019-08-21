import 'package:test/test.dart';
import 'package:example/posts_page.dart';

void main() {
  test(
    "shoud return true if page path match posts page path",
    () {
      expect(PostsPage.match("/users/1234/posts"), isTrue);
    },
  );

  test(
    "should return false if page path does not match full posts page path",
    () {
      expect(PostsPage.match("/users/1234/posts/"), isFalse);
    },
  );
}
