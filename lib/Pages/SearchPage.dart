import 'package:flutter/material.dart';
import 'package:infomusic2/Widgets/ResultsCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  late ResultsCard _resultsCard;
  static String query = "";

  void updateResults() {
    _resultsCard = new ResultsCard(query);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _resultsCard = new ResultsCard(query);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build SearchPage, query: $query");
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Search'),
            onSubmitted: (String value) {
              assert(this.mounted==true);
              setState(() {
                query = value;
                print("TextField query: $query ${this.mounted}");
                updateResults();
              });
            },
          ),
          Flexible(
            child: _resultsCard,
          ),
        ],
      ),
    );
  }
}
