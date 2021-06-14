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
      body: Column(
        children: [
          Text("road work ahead",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Flexible(
            child: FavoritesCard(),
          ),
        ],
      ),
    );
  }
}
