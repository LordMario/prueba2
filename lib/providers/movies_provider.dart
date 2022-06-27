import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/busqueda.dart';
import 'package:peliculas/models/cast.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/models/now_playing.dart';
import 'package:peliculas/models/pupolars_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey    = '34f8e1965288db587fddeb7986372d12';
  String _baseUrl   = 'api.themoviedb.org';
  String _languaje  = 'es-ES';

  int _popularPage=0;

  List <Movie> onDislplayMovie = []; 
  List <Movie> popularsMovies  = [];
  List <Movie> busquedaMovie   = [];
  Map<int, List<Cast>> casting = {};

  MoviesProvider(){
    getOnDisplayMovie();
    getPopularsMovies();
  }
  getOnDisplayMovie() async{
    final response        = await _getJsonData('/3/movie/now_playing');
    final respuesta       = NowPlaying.fromJson(response);
    onDislplayMovie       = respuesta.results;
    notifyListeners();
  }
  getPopularsMovies() async{
    _popularPage++;
    final response          = await _getJsonData('/3/movie/popular',_popularPage);
    final respuestaPopular  = Populars.fromJson(response);
    popularsMovies          = [...popularsMovies,...respuestaPopular.results];
    notifyListeners();
  }
  Future <List<Movie>> searchMovie(String query) async{
    final url = Uri.https(_baseUrl,'/3/search/movie',{
      'api_key' :_apiKey,
      'language':_languaje,
      'query'   : query,
    });
    final response            = await http.get(url);
    final resultadoBusqueda   = Busqueda.fromJson(response.body);
    busquedaMovie             = resultadoBusqueda.results;
    return busquedaMovie;
  }

  Future <List<Cast>> getCast(int id) async{
    if(casting.containsKey(id)) return casting[id];
    final url = Uri.https(_baseUrl,'/3/movie/$id/credits',{
      'api_key' :_apiKey,
      'language':_languaje,
    });
    final response          = await http.get(url);
    final respuestaCredits  = Credits.fromJson(response.body);
    casting[id]=respuestaCredits.cast;
    return  respuestaCredits.cast;
  }
  
  Future<String> _getJsonData(String peticion , [int page = 1] ) async{
    final url = Uri.https(_baseUrl,peticion,{
      'api_key' :_apiKey,
      'language':_languaje,
      'page'    :'$page',
    });
    final response          = await http.get(url);
    return response.body;
  }
}