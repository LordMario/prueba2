import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final Function pelisPopulares;

  const MovieSlider({Key key, this.movies, this.pelisPopulares}) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

 final ScrollController _scroll = new ScrollController();
  @override
  void initState(){
    super.initState();
    _scroll.addListener(() {
      if(_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200){
        print('object');
        widget.pelisPopulares();
      }
    });
  }
  @override
  void dispose(){
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 205,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Populares",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
          ),
          SizedBox(height: 2,),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              itemCount: widget.movies.length,
              itemBuilder: (_,index)=> _MoviePoster(widget.movies[index]),            
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
class _MoviePoster extends StatelessWidget {

  final Movie pelicula;
  const _MoviePoster( this.pelicula);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()=> Navigator.pushNamed(context, 'details', arguments: pelicula),
            child: ClipRRect(        
              borderRadius: BorderRadius.circular(20),  
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(pelicula.fullPoster),
                fit: BoxFit.cover,
                height: 150,
                width: 130,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text(pelicula.title,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}