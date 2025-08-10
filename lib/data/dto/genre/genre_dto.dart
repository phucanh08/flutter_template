import 'package:flutter/foundation.dart';

@immutable
class GenreDto {
  final String name;
  final String href;
  final String script;

  const GenreDto({
    required this.name,
    required this.href,
    required this.script,
  });

  factory GenreDto.fromJson(Map<String, dynamic> json) =>
      GenreDto(name: json['name'], href: json['href'], script: json['script']);

  @override
  String toString() => 'GenreDto(name:$name, href:$href, script:$script)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GenreDto &&
        other.name == name &&
        other.href == href &&
        other.script == script;
  }

  @override
  int get hashCode =>
      Object.hash(name.hashCode, href.hashCode, script.hashCode);
}
