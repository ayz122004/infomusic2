import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infomusic2/Widgets/SongCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResultsCard extends StatefulWidget {
  final String query;
  //const ResultsCard({Key? key}) : super(key: key);
  ResultsCard(this.query);

  @override
  _ResultsCardState createState() => _ResultsCardState();
}

class _ResultsCardState extends State<ResultsCard> {
  String query = "";
  List<String> searchResultAPIPaths = [];

  Future<List<String>> fetchSearchData() async {
    // query = widget.query;
    print("fetchSearchData query: $query");
    var response = await http.get(
      // Uri.parse("https://api.genius.com/search?q=avicii%20the%20nights"),
      Uri.parse("https://api.genius.com/search?q=$query"),
      headers: {
        'Accept': 'application/json',
        'Host': 'api.genius.com',
        'Authorization':
            'Bearer pYecHXJg1MiLG_2Hx3FRlZCugQ8Td2FTJi3oOsN-3Zh9eAanCVDPcpPmhefUBWe1',
      },
    );

    List<String> links = [];
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (int i = 0; i < jsonData["response"]["hits"].length; i++) {
        links.add(jsonData["response"]["hits"][i]["result"]["api_path"]);
      }
    } else {
      throw Exception('Failed to load search results');
    }
    return links;
  }

  @override
  void initState() {
    super.initState();
    print("ResultsCard initState called");
    query = widget.query;
    fetchSearchData().then((value) {
      // searchResultAPIPaths.addAll(value);
      // print(
      //     "initState fetchSearchData called. searchResults length: ${searchResultAPIPaths.length}");
      assert(this.mounted==true);
      setState(() {
        searchResultAPIPaths.addAll(value);
        print(
            "initState fetchSearchData called. searchResults length: ${searchResultAPIPaths.length}");
      });
    });
  }

  void updateSearchResults() {
    print("updateSearchResults called, query: $query");
    fetchSearchData().then((value) {
      assert(this.mounted==true);
      setState(() {
        if (searchResultAPIPaths.length == 0) {
          searchResultAPIPaths.addAll(value);
        } else {
          searchResultAPIPaths.setAll(0, value);
        }
      });
    });
  }

  List<SongCard> buildList() {
    print("buildList called, query: $query");
    List<SongCard> list = [];
    for (int i = 0; i < searchResultAPIPaths.length; i++) {
      list.add(new SongCard(searchResultAPIPaths[i]));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    assert(this.mounted==true);
    setState(() {
      query = widget.query;
      updateSearchResults();
    });
    print("build ResultsCard, query: $query");
    // setState(() {
    //   buildList();
    // });
    return ListView(
      children: buildList(),
    );
  }
}
