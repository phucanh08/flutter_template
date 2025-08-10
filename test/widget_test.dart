import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

String getAttr(String html, String name) {
  final fragment = html_parser.parseFragment(html);
  if (fragment.nodes.isNotEmpty && fragment.nodes.first is dom.Element) {
    final el = fragment.nodes.first as dom.Element;
    return el.attributes[name] ?? '';
  }
  return '';
}

void main() {
  final html = r'''<img loading="lazy" src="https://cdn.banlong.xyz/uploads/cover/thumbs/350x0/giang-son-chien-do.jpg" data-src="https://cdn.banlong.xyz/uploads/cover/thumbs/350x0/giang-son-chien-do.jpg" alt="Giang Sơn Chiến Đồ" class="img-fluid">''';

  print(getAttr(html, 'src')); // abc.jpg
  print(getAttr(html, 'alt')); // demo
}
