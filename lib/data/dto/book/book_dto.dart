import 'package:flutter/cupertino.dart';

import '../genre/genre_dto.dart';


@immutable
class BookDto {
  final String name;
  final String href;
  final String img;
  final String desc;

  const BookDto({
    required this.name,
    required this.href,
    required this.img,
    required this.desc,
  });

  factory BookDto.fromJson(Map<String, dynamic> json) => BookDto(
    name: json['name'],
    href: json['href'],
    img: json['img'],
    desc: json['desc'],
  );

  @override
  String toString() =>
      'BookDto(name:$name, href:$href, script:$img, desc:$desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BookDto &&
        other.name == name &&
        other.href == href &&
        other.img == img &&
        other.desc == desc;
  }

  @override
  int get hashCode =>
      Object.hash(name.hashCode, href.hashCode, img.hashCode, desc.hashCode);
}

@immutable
class BookDetailDto {
  final String name;
  final String img;
  final String author;
  final String description;
  final List<GenreDto> genres;
  final String detail;
  final bool ongoing;
  final String tocUrl;

  const BookDetailDto({
    required this.name,
    required this.img,
    required this.author,
    required this.description,
    required this.genres,
    required this.detail,
    required this.ongoing,
    required this.tocUrl,
  });

  factory BookDetailDto.fromJson(Map<String, dynamic> json) => BookDetailDto(
    name: json['name'],
    img: json['img'],
    author: json['author'],
    description: json['description'],
    genres: (json['genres'] as List).map((e) => GenreDto.fromJson(e)).toList(),
    detail: json['detail'],
    ongoing: json['ongoing'],
    tocUrl: json['tocUrl'],
  );

  @override
  String toString() =>
      'BookDetailDto(name:$name, href:$img, script:$author, desc:$description, genres:$genres, detail:$detail, ongoing:$ongoing, tocUrl:$tocUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BookDetailDto &&
        other.name == name &&
        other.img == img &&
        other.author == author &&
        other.description == description &&
        other.genres == genres &&
        other.detail == detail &&
        other.ongoing == ongoing &&
        other.tocUrl == tocUrl;
  }

  @override
  int get hashCode => Object.hash(
    name.hashCode,
    img.hashCode,
    author.hashCode,
    description.hashCode,
    genres.hashCode,
    detail.hashCode,
    ongoing.hashCode,
    tocUrl.hashCode,
  );
}
