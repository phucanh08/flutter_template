import 'package:flutter/foundation.dart';

@immutable
class ChapterDto {
  final String name;
  final String href;
  final bool pay;

  const ChapterDto({required this.name, required this.href, required this.pay});

  factory ChapterDto.fromJson(Map<String, dynamic> json) =>
      ChapterDto(name: json['name'], href: json['href'], pay: json['pay']);

  @override
  String toString() => 'ChapterDto(name:$name, href:$href, pay:$pay)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChapterDto &&
        other.name == name &&
        other.href == href &&
        other.pay == pay;
  }

  @override
  int get hashCode => Object.hash(name.hashCode, href.hashCode, pay.hashCode);
}
