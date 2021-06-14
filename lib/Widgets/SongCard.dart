import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infomusic2/GeniusObjects/Song.dart';
import 'package:infomusic2/Widgets/FavoritesCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SongCard extends StatefulWidget {
  final String apiPath;
  bool isFavorite = false;
  //const SongCard({Key? key}) : super(key: key);
  SongCard(this.apiPath);

  @override
  _SongCardState createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  late Future<Song> song;
  bool isFavorite = false;

  Future<Song> fetchSongData(String apiPath) async {
    final response = await http.get(
      Uri.parse('https://api.genius.com$apiPath'),
      headers: {
        'Accept': 'application/json',
        'Host': 'api.genius.com',
        'Authorization':
            'Bearer pYecHXJg1MiLG_2Hx3FRlZCugQ8Td2FTJi3oOsN-3Zh9eAanCVDPcpPmhefUBWe1',
      },
    );
    if (response.statusCode == 200) {
      return Song.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load song info');
    }
  }

  @override
  void initState() {
    super.initState();
    song = fetchSongData(widget.apiPath);
  }

  IconButton buildIconButton() {
    Icon icon;
    if (isFavorite) {
      icon = Icon(Icons.favorite, color: Colors.red);
    } else {
      icon = Icon(Icons.favorite_border);
    }

    IconButton iconButton = new IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
          addSong(this.widget);
        });
    return iconButton;
  }

  Card buildSongCard() {
    try {
      Card card = new Card(
        margin: EdgeInsets.all(16),
        child: FutureBuilder<Song>(
            future: song,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  leading: new Image.network("${snapshot.data!.imageLink}"),
                  trailing: buildIconButton(),
                  title: Text(
                      "${snapshot.data!.title} by ${snapshot.data!.artist}"),
                  isThreeLine: true,
                  subtitle: Text(
                      "Album: ${snapshot.data!.album}\nDate: ${snapshot.data!.date}"),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Text("loading...");
            }),
      );
      return card;
    } catch (Exception) {
      return new Card(child: Text("error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildSongCard();
  }
}
