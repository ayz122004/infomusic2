import 'package:flutter/material.dart';
import 'package:infomusic2/Widgets/FavoritesCard.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(32),
      //   child: Text(
      //     "under construction",
      //     style: TextStyle(fontSize: 24),
      //   ),
      // ),

      body: Column(
        children: [
          Text("under construction", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
          Flexible(
            child: new FavoritesCard(),
          ),
        ],
      ),
    );
  }
}
