import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/widgets/casting_cards.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie pelicula= ModalRoute.of(context).settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(pelicula: pelicula),
          SliverList(
            delegate:SliverChildListDelegate([
              _PosterAndTitle(pelicula),
              SizedBox(height: 5),
              _Overview(pelicula.overview),
              SizedBox(height: 3),
              Text('Casting',style: TextStyle(fontSize:30 )),
              CastingCards(pelicula.id),
            ]) ,
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie pelicula;

  const _CustomAppBar({Key key, this.pelicula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          color: Colors.black26,
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          child: Text(pelicula.title,style:TextStyle(fontSize:16 ), textAlign: TextAlign.center,),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage(pelicula.fullbackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
class _PosterAndTitle extends StatelessWidget  {

  final Movie movie;

  const _PosterAndTitle( this.movie);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tema= Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.all(3) ,
      child:Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'), 
              image: NetworkImage(movie.fullPoster),
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width-150 ),
                child:Text(movie.title,style: tema.headline5,overflow: TextOverflow.ellipsis,  maxLines: 2,),          
              ),
              SizedBox(height: 10,),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width-150 ),
                child: Text(movie.originalTitle, style: tema.headline6, overflow: TextOverflow.ellipsis,  maxLines: 2,),
              ),
              Row(
                children: [
                  Icon(Icons.star_border,size: 20,),
                  SizedBox(width: 2,),
                  Text('${movie.voteAverage}', style: tema.caption,textAlign: TextAlign.justify,),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
class _Overview extends StatelessWidget {
  final String overview;

  const _Overview( this.overview);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),      
      child: Text(overview,textAlign: TextAlign.justify,),
    );
  }
}
