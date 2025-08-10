import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_js/javascriptcore/jscore_runtime.dart';
import 'package:flutter_template/data/dto/base/base_response.dart';
import 'package:flutter_template/data/dto/book/book_dto.dart';
import 'package:flutter_template/data/extensions/fetch.dart';
import 'package:flutter_template/data/extensions/jsoup.dart';

import '../dto/chapter/chapter_dto.dart';
import '../dto/genre/genre_dto.dart';
import '../dto/tab/tab_dto.dart';

class ExtensionRepoImpl {
  late JavascriptRuntime runtime;
  final pluginName = "BanLong";

  Future<void> init() async {
    if (Platform.isAndroid) {
      runtime = QuickJsRuntime2(stackSize: 1024 * 1024);
    } else if (Platform.isWindows) {
      runtime = QuickJsRuntime2();
    } else if (Platform.isLinux) {
      runtime = JavascriptCoreRuntime();
    } else {
      runtime = JavascriptCoreRuntime();
    }

    runtime.enableHandlePromises();
    runtime.enableJsoup();
    runtime.enableFetch();

    String core = await rootBundle.loadString('assets/js/core.js');
    String jsCode = await rootBundle.loadString('assets/js/banlong.js');

    jsCode = jsCode.replaceAll(
      "export default class extends Extension {",
      "class ${pluginName}Extension {",
    );
    runtime.evaluate('''
      $core
      $jsCode
      var ${pluginName}Instance = new ${pluginName}Extension();
    ''');
  }

  test() async {
    chapter("https://banlong.pro/truyen/bat-dau-nap-tien-mot-ty/chuong-1");

    final bookDetailResult = await detail("https://banlong.pro/truyen/duong-nhan-dich-xan-trac");
    print(bookDetailResult.data);
    final tocUrl = bookDetailResult.data?.tocUrl;
    if (tocUrl == null) return;
    toc(tocUrl);

    final genresResult = await genres();
    final result = await home();

    final tabs = result.data;
    if (tabs.isNotEmpty != true) return;
    final tab = tabs[5];
    final tabDetail = await this.tab(tab.script, tab.href);
    print(tabDetail.data);
  }

  void search() {}

  Future<PaginationResponse<BookDto>> tab(String script, String url, [String? page]) async {
    var result = await runtime.handlePromise(
      await runtime.evaluateAsync(
        "${pluginName}Instance.$script(\"$url\", $page)",
      ),
    );

    final json = jsonDecode(result.stringResult);
    if (json['status'] == false) throw Exception("Lỗi khi lấy dữ liệu tab");

    final books = (json['data'] as List)
        .map((e) => BookDto.fromJson(e as Map<String, dynamic>))
        .toList();
    return PaginationResponse<BookDto>(data: books, nextPage: json['next']);
  }

  Future<PaginationResponse<TabDto>> home() async {
    var result = await runtime.handlePromise(
      await runtime.evaluateAsync("${pluginName}Instance.home()"),
    );

    final json = jsonDecode(result.stringResult);
    final tabs = (json['data'] as List)
        .map((e) => TabDto.fromJson(e as Map<String, dynamic>))
        .toList();
    return PaginationResponse<TabDto>(data: tabs);
  }

  Future<PaginationResponse<GenreDto>> genres() async {
    var result = await runtime.handlePromise(
        await runtime.evaluateAsync("${pluginName}Instance.genres()"),
    );
    final json = jsonDecode(result.stringResult);
    final genres = (json['data'] as List)
        .map((e) => GenreDto.fromJson(e as Map<String, dynamic>))
        .toList();
    return PaginationResponse<GenreDto>(data: genres);
  }

  Future<BaseResponse<BookDetailDto>> detail(String url) async {
    final result = await runtime.handlePromise(
      await runtime.evaluateAsync("${pluginName}Instance.detail(\"$url\")"),
    );

    final json = jsonDecode(result.stringResult);
    final bookDetail = BookDetailDto.fromJson(json['data']);
    return BaseResponse<BookDetailDto>(data: bookDetail);
  }

  Future<PaginationResponse<ChapterDto>> toc(String url) async {
    final result = await runtime.handlePromise(
        await runtime.evaluateAsync("${pluginName}Instance.toc(\"$url\")"),
    );
    final json = jsonDecode(result.stringResult);
    final chapters = (json['data'] as List)
        .map((e) => ChapterDto.fromJson(e as Map<String, dynamic>))
        .toList();
    return PaginationResponse<ChapterDto>(data: chapters);
  }

  Future<BaseResponse<String>> chapter(String url) async {
    final result = await runtime.handlePromise(
        await runtime.evaluateAsync("${pluginName}Instance.chapter(\"$url\")"),
    );
    final json = jsonDecode(result.stringResult);
    return BaseResponse<String>(data: json['data']);
  }
}
