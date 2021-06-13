import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infomusic2/GeniusObjects/Song.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

class SongCard extends StatefulWidget {
  final String apiPath;
  //const SongCard({Key? key}) : super(key: key);
  const SongCard(this.apiPath);

  @override
  _SongCardState createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  late Future<Song> song;

  @override
  void initState() {
    super.initState();
    song = fetchSongData(widget.apiPath);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Song>(
            future: song,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Artist: " + snapshot.data!.artist),
                    Text("Album: " + snapshot.data!.album),
                    Text(snapshot.data!.date),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Text("loading...");
            }),
      ),
    );
  }
}
