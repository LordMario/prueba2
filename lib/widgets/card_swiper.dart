import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:peliculas/models/movie.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if(movies.length==0){
      return Container(
        width: double.infinity,
        height: size.height*0.55,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height*0.55,
      child: Swiper(
        itemCount:movies.length,
        layout: SwiperLayout.STACK,
        itemHeight: size.height*0.5,
        itemWidth: size.width*0.5,
        itemBuilder: (_,index){       
          final movie= movies[index] ; 
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 'details',arguments: movies[index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPoster),
                fit: BoxFit.cover,
              ),              
            ),
          );
        },
      ),
    );
  }
}