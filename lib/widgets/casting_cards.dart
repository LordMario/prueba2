import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/cast.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int id;
 
  const CastingCards(this.id);
  @override
  Widget build(BuildContext context) {

    final cast= Provider.of<MoviesProvider>(context,listen: false);

    return FutureBuilder(
      future: cast.getCast(id),
      builder: ( _ , AsyncSnapshot<List<Cast>> snapshot){ 

        if(!snapshot.hasData){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 175,
            child: ListView.builder(
            itemBuilder: (_, index){
              return  ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CupertinoActivityIndicator(),
              );
              
            },
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),           
          ); 
        }
        final actores= snapshot.data;
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          height: 175,
          child: ListView.builder(
            itemBuilder: (_, index){
              return _CastCard(actores[index]);
            },
            itemCount: actores.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      }
    );
  } 
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard(this.actor);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [        
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 135,
              placeholder: AssetImage('assets/loading.gif'), 
              image: NetworkImage(actor.fullprofilePath),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 38,
            padding: EdgeInsets.only(left: 10),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 100 ),
              child:Text(actor.name,overflow: TextOverflow.ellipsis,  maxLines: 2, textAlign: TextAlign.center,),          
            ), 
          ),
        ],
      ),
    );
  }
} 