import 'dart:convert';
import 'package:bible_verse_generator/src/views/my_progress_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:bible_verse_generator/src/utilities/string.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  bool hasError = false;
  Scripture randomScripture;
  @override
  void initState() {
    _fetchScripture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: isLoading ? CircularProgressIndicator() : _buildCard(),
        )),
        floatingActionButton: _buildFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
  }

  Padding _buildFab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FloatingActionButton.extended(
        onPressed: () => _fetchScripture(),
        tooltip: 'Shuffle',
        label: Text('Shuffle'),
        icon: isLoading
            ? MyProgressIndicator(
                color: Colors.black,
                size: 16,
              )
            : Icon(Icons.shuffle),
      ),
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
      style: TextStyle(
          fontWeight: FontWeight.w600,  fontSize: 24),
      textAlign: TextAlign.center,
    );
  }

  Text _buildDetails() {
    return Text(
      '${randomScripture.bookName} ${randomScripture.chapter}:${randomScripture.verse}',
      style: TextStyle(
        // color: Colors.white70,
      ),
      textAlign: TextAlign.center,
    );
  }

  Future<void> _fetchScripture() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(randomBibleVerseUrl);

    if (response.statusCode == 200) {
      Scripture _randomScripture =
          Scripture.fromJson(json.decode(response.body)[0]);
      setState(() {
        randomScripture = _randomScripture;
        isLoading = false;
      });
    } else {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      throw Exception('Failed to load scripture');
    }
  }
}
