import "package:dbpage_routing/dbpage_routing.dart";

part "detail_page.g.dart";

@PagePath("https://mywebsite.com/detail?productId=int")
class DetailPage {
  static bool matchRoute(final String path) {
    return $matchRoute(path);
  }
}