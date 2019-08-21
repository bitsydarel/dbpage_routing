import 'package:example/detail_page.dart';
import 'package:test/test.dart';

void main() {
  group(
    "verify if detail page path match is correct",
    () {
      test("should return true if page path match detail page path", () {
        expect(DetailPage.matchRoute("https://mywebsite.com/detail"), isTrue);
      });

      test(
        "should return true if page path with arguments match the detail page",
        () {
          expect(
            DetailPage.matchRoute("https://mywebsite.com/detail?productId=45"),
            isTrue,
          );
        },
      );

      test(
        "should return false if page path does not match detail page path",
        () {
          expect(DetailPage.matchRoute("https://mywebsite.com/other"), isFalse);
        },
      );

      test(
        "should return false if page path does not match detail page path",
        () {
          expect(
            DetailPage.matchRoute(
              "https://mywebsite.com",
            ),
            isFalse,
          );
        },
      );
    },
  );
}
