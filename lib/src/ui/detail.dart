import 'package:flutter/material.dart';
import 'package:uas/src/models/anggreks.dart';

class Detail extends StatelessWidget {
  final Anggreks anggreks;
  Detail({@required this.anggreks});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink[200],
      ),
      body: new Stack(
        children: <Widget>[
          // new Image(
          //   image: new AssetImage('images/background.jpg'),
          //   fit: BoxFit.cover,
          //   color: Colors.black38,
          //   colorBlendMode: BlendMode.darken,
          // ),
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Padding(padding: new EdgeInsets.only(bottom: 50.0),),
                  Text(
                    anggreks.name,
                    style:TextStyle(
                      fontSize: 25.0, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "Price : ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  ),
                  Text(
                    "Rp. ${anggreks.price}",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  Text(
                    "Deskripsi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  ),
                  Text(
                    "${anggreks.desc}",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  Padding(padding: new EdgeInsets.only(bottom: 50.0),),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: pokemon.type
                  //       .map((t) => FilterChip(
                  //           backgroundColor: Colors.amber,
                  //           label: Text(t),
                  //           onSelected: (b) {}))
                  //       .toList(),
                  // ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: anggreks.image,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                    fit: BoxFit.cover, 
                    image: NetworkImage(anggreks.image)
                  )
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}