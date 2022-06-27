import 'dart:convert';

import 'movie.dart';

class Busqueda {
    Busqueda({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory Busqueda.fromJson(String str) => Busqueda.fromMap(json.decode(str));

    factory Busqueda.fromMap(Map<String, dynamic> json) => Busqueda(
        page          : json["page"],
        results       : List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages    : json["total_pages"],
        totalResults  : json["total_results"],
    );
}
