import 'package:flutter/material.dart';
import 'package:infomusic2/Widgets/SongCard.dart';

List<SongCard> favoritesList = [];

void addSong(SongCard songCard) {
  SongCard newSongCard = new SongCard(songCard.apiPath);
  newSongCard.isFavorite = true;
  favoritesList.add(newSongCard);
  print("song added. isFavorite: ${favoritesList[favoritesList.length-1].isFavorite}");
}

class FavoritesCard extends StatefulWidget {
  const FavoritesCard({Key? key}) : super(key: key);

  @override
  _FavoritesCardState createState() => _FavoritesCardState();
}

class _FavoritesCardState extends State<FavoritesCard> {
  @override
  Widget build(BuildContext context) { //will build everytime you navigate to Favorites Page. i think. hopefully.
    return ListView(
      children: favoritesList,
      physics: BouncingScrollPhysics(),
    );
  }
}
