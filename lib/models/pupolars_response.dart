import 'dart:convert';

import 'package:peliculas/models/movie.dart';

class Populars {
    Populars({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory Populars.fromJson(String str) => Populars.fromMap(json.decode(str));

    factory Populars.fromMap(Map<String, dynamic> json) => Populars(
        page        : json["page"],
        results     : List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages  : json["total_pages"],
        totalResults: json["total_results"],
    );
}