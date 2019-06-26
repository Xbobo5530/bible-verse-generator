import 'dart:convert';
import 'package:bible_verse_generator/src/views/share_button.dart';
import 'package:bible_verse_generator/src/views/shuffle_button.dart';
import 'package:http/http.dart' as http;
import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:bible_verse_generator/src/utilities/string.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  bool hasError = false;
  Scripture randomScripture;

  @override
  void initState() {
    _fetchScripture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _shuffleButton = ShuffleButton(
      onPressed: () => _fetchScripture(),
      isLoading: _isLoading,
    );

    final _previousButton = FloatingActionButton(
        child: Icon(Icons.skip_previous), onPressed: _goToPReviousVerse());
    final _shareButton = ShareButton(
      scripture: randomScripture,
    );
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading ? CircularProgressIndicator() : _buildCard(),
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _previousButton,
          _shuffleButton,
          _shareButton,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Card _buildCard() {
    return Card(
      color: Colors.lime,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: _buildMainText(),
          subtitle: _buildDetails(),
        ),
      ),
    );
  }

  Text _buildMainText() {
    return Text(
      randomScripture.text,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      textAlign: TextAlign.center,
    );
  }

  Text _buildDetails() {
    return Text(
      '${randomScripture.bookName} ${randomScripture.chapter}:${randomScripture.verse}',
      style: TextStyle(),
      textAlign: TextAlign.center,
    );
  }

  Future<void> _fetchScripture() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(randomBibleVerseUrl);

    if (response.statusCode == 200) {
      Scripture _randomScripture =
          Scripture.fromJson(json.decode(response.body)[0]);
      setState(() {
        randomScripture = _randomScripture;
        _isLoading = false;
      });
    } else {
      setState(() {
        hasError = true;
        _isLoading = false;
      });
      throw Exception('Failed to load scripture');
    }
  }

  _goToPReviousVerse() {
    //TODO: handle go to previous verse
    /// create an array from which the [Card] will be fetching the verse from
    /// or show previous verse can just check what the previous verse was on the array
    /// when previous verse is shown maybe show the next action button
  }
}
