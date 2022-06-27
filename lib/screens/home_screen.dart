import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/card_swiper.dart';
import 'package:peliculas/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider  =Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Peliculas en cine"),
        actions: [
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){
              showSearch(
                context: context, 
                delegate: MovieSearchDelegate(),
              );
            }
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper( movies: moviesProvider.onDislplayMovie,),
            MovieSlider(movies: moviesProvider.popularsMovies, pelisPopulares: (){
              moviesProvider.getPopularsMovies();
            }, ),
          ],
        ),
      ),
    );
  }
}