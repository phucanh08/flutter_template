import 'dart:convert';
import 'package:flutter_js/javascript_runtime.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as html;

/// Tên kênh (message) cố định để JS gọi
const _kSelectAll = "js_select_all";        // [content, selector] -> List<String outerHtml>
const _kSelectFirst = "js_select_first";    // [content, selector] -> String outerHtml (hoặc '')
const _kText = "js_text";                   // [html] -> String
const _kOuterHtml = "js_outer_html";        // [html] -> String
const _kInnerHtml = "js_inner_html";        // [html] -> String
const _kAttr = "js_attr";                   // [html, name] -> String?

extension JavascriptRuntimeFetchExtension on JavascriptRuntime {
  Future<JavascriptRuntime> enableJsoup() async {
    onMessage(_kSelectAll, _jsSelectAll);
    onMessage(_kSelectFirst, _jsSelectFirst);
    onMessage(_kText, _jsText);
    onMessage(_kOuterHtml, _jsOuterHtml);
    onMessage(_kInnerHtml, _jsInnerHtml);
    onMessage(_kAttr, _jsAttr);
    evaluate(_jsoup); // nạp class Element/Elements ở JS
    return this;
  }

  List _asList(dynamic args) {
    if (args is List) return args;
    if (args is String) {
      try {
        final v = jsonDecode(args);
        if (v is List) return v;
      } catch (_) {}
    }
    return const [];
  }

  // [content, selector] -> List<String outerHtml>
  dynamic _jsSelectAll(dynamic args) {
    final a = _asList(args);
    final content = (a.isNotEmpty ? a[0] : '')?.toString() ?? '';
    final selector = (a.length > 1 ? a[1] : '')?.toString() ?? '';
    if (selector.trim().isEmpty) {
      // jsoup: select("") -> rỗng; bạn có thể đổi sang "*" nếu muốn lấy tất cả
      return jsonEncode(<String>[]);
    }
    try {
      final doc = parse(content).querySelectorAll(selector);
      return jsonEncode(doc.map((e) => e.outerHtml).toList());
    } catch (e) {
      // selector sai -> trả list rỗng cho tiện chain
      return jsonEncode(<String>[]);
    }
  }

  // [content, selector] -> String outerHtml (hoặc '')
  dynamic _jsSelectFirst(dynamic args) {
    final a = _asList(args);
    final content = (a.isNotEmpty ? a[0] : '')?.toString() ?? '';
    final selector = (a.length > 1 ? a[1] : '')?.toString() ?? '';
    if (selector.trim().isEmpty) return '';
    try {
      final el = parse(content).querySelector(selector);
      return el?.outerHtml ?? '';
    } catch (e) {
      return '';
    }
  }

  // [html] -> text
  dynamic _jsText(dynamic args) {
    final a = _asList(args);
    final htmlStr = (a.isNotEmpty ? a[0] : '')?.toString() ?? '';
    if (htmlStr.isEmpty) return '';
    return parse(htmlStr).documentElement?.text ?? '';
  }

  // [html] -> outerHTML
  dynamic _jsOuterHtml(dynamic args) {
    final a = _asList(args);
    final htmlStr = (a.isNotEmpty ? a[0] : '')?.toString() ?? '';
    if (htmlStr.isEmpty) return '';
    return parse(htmlStr).documentElement?.outerHtml ?? '';
  }

  // [html] -> innerHTML
  dynamic _jsInnerHtml(dynamic args) {
    final a = _asList(args);
    final htmlStr = (a.isNotEmpty ? a[0] : '')?.toString() ?? '';
    if (htmlStr.isEmpty) return '';
    final root = parse(htmlStr).documentElement;
    return root?.innerHtml ?? '';
  }

  // [html, name] -> attr value (của element root truyền vào)
  dynamic _jsAttr(dynamic args) {
    final a = _asList(args);
    final htmlStr = (a.isNotEmpty ? a[0] : '')?.toString() ?? '';
    final name = (a.length > 1 ? a[1] : '')?.toString() ?? '';
    if (htmlStr.isEmpty || name.isEmpty) return '';
    try {
      final frag = parseFragment(htmlStr);
      for (final node in frag.nodes) {
        if (node is html.Element) {
          return node.attributes[name] ?? '';
        }
      }
      return '';
    } catch (_) {
      return '';
    }
  }
}


const querySelectorJsoup = "querySelectorJsoup";
const textJsoup = "textJsoup";
const outerHtmlJsoup = "outerHtmlJsoup";
const innerHtmlJsoup = "innerHtmlJsoup";
final _jsoup = '''
// Tên message phải khớp Dart
const _kSelectAll   = "js_select_all";
const _kSelectFirst = "js_select_first";
const _kText        = "js_text";
const _kOuterHtml   = "js_outer_html";
const _kInnerHtml   = "js_inner_html";
const _kAttr        = "js_attr";

// tiện ích: gọi kênh và parse JSON khi cần
function _call(name, payloadArray) {
  // flutter_js yêu cầu message là String → stringify
  const res = sendMessage(name, JSON.stringify(payloadArray));
  return res;
}

class Element {
  constructor(html, selector = "") {
    this._html = html || "";        // outerHTML của node hiện tại
    this._selector = selector || ""; // selector hiện hành (tuỳ bạn dùng)
  }

  // jsoup: el.select(css) -> Elements
  select(css) {
    const raw = _call(_kSelectAll, [this._html, css || ""]);
    let arr;
    try { arr = JSON.parse(raw) || []; } catch { arr = []; }
    return new Elements(arr.map(s => new Element(s, "")));
  }

  // jsoup: el.text(), el.html(), el.outerHtml()
  text()      { return _call(_kText,      [this._html]); }
  html()      { return _call(_kInnerHtml, [this._html]); }   // tương đương innerHTML
  outerHtml() { return _call(_kOuterHtml, [this._html]); }
  attr(name)  { return _call(_kAttr,      [this._html, name || ""]); }
}

class Elements {
  constructor(items) {
    this._items = Array.isArray(items) ? items : [];
  }

  // jsoup: elements.select(css) -> apply cho từng phần tử và flatten
  select(css) {
    const out = [];
    for (const el of this._items) {
      const raw = _call(_kSelectAll, [el._html, css || ""]);
      let arr;
      try { arr = JSON.parse(raw) || []; } catch { arr = []; }
      for (const s of arr) out.push(new Element(s, ""));
    }
    return new Elements(out);
  }

  // jsoup: elements.first()
  first() {
    return this._items.length ? this._items[0] : null;
  }

  // jsoup: elements.get(i)
  get(i) {
    return (i >= 0 && i < this._items.length) ? this._items[i] : null;
  }

  // jsoup: elements.size()
  size() { return this._items.length; }

  // jsoup: elements.eachText() tương tự (đơn giản hoá)
  eachText() {
    return this._items.map(el => el.text());
  }
  
  attr(name) {
    if (!name || this._items.length === 0) return '';
    return this._items[0].attr(name) || '';
  }
  
  html() {
    return this._items.map(el => el.html()).join('');
  }
  
  text() {
    return this._items.map(el => el.text()).join(' ').trim();
  }
  
  forEach(cb, thisArg) { this._items.forEach(cb, thisArg); }
  map(cb, thisArg)     { return this._items.map(cb, thisArg); }
  filter(cb, thisArg)  { return new Elements(this._items.filter(cb, thisArg)); }
  at(i)                { return this._items.at(i); }
  toArray()            { return [...this._items]; }
  get length()         { return this._items.length; }
  isEmpty()            { return this._items.length === 0; }


  // tiện ích để lặp
  [Symbol.iterator]() { return this._items[Symbol.iterator](); }
}

// “Document” khởi đầu: bơm HTML string và chọn gốc
class Document {
  constructor(html) {
    this._root = new Element(html, "html");
  }
  select(css) {
    // jsoup: Document.select(css) -> Elements
    return this._root.select(css);
  }
  // nhanh: chọn toàn bộ <a>...
  get root() { return this._root; }
}
''';
