import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query='';
        }, 
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context,null);
      }, 
      icon: Icon(Icons.arrow_back),
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('jose');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return Center(
        child: Container(
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.black26,
            size: 100,
          ) ,
        ),
      );
    }
    final cast= Provider.of<MoviesProvider>(context,listen: false);
    return FutureBuilder(
      future: cast.searchMovie(query),
      builder: ( _ , AsyncSnapshot<List<Movie>> snapshot){
        if(!snapshot.hasData){
          return Container();
        }
        final pelis= snapshot.data;
        return ListView.builder(
          itemCount: pelis.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: ListTile(
                leading:FadeInImage(
                  fit: BoxFit.contain,
                  width: 50,
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(pelis[index].fullPoster),
                ),
                title: Text(pelis[index].title),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: (){

                },
              ),              
            );
          },
        );
      },
    );
  }

}