import 'package:flutter/foundation.dart';

@immutable
class TabDto {
  final String name;
  final String href;
  final String script;

  const TabDto({required this.name, required this.href, required this.script});

  factory TabDto.fromJson(Map<String, dynamic> json) => TabDto(
    name: json['name'],
    href: json['href'],
    script: json['script'],
  );

  @override
  String toString() => 'TabDto(name:$name, href:$href, script:$script)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabDto &&
        other.name == name &&
        other.href == href &&
        other.script == script;
  }

  @override
  int get hashCode =>
      Object.hash(name.hashCode, href.hashCode, script.hashCode);
}
