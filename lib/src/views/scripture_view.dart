import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:flutter/material.dart';

class ScriptureView extends StatefulWidget {
  final Scripture scripture;

  const ScriptureView({Key key, @required this.scripture}) : super(key: key);

  @override
  _ScriptureViewState createState() => _ScriptureViewState();
}

class _ScriptureViewState extends State<ScriptureView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: _buildMainText(widget.scripture),
          subtitle: _buildDetails(widget.scripture),
        ),
      ),
    );
  }

  Text _buildMainText(Scripture scripture) {
    return Text(
      scripture.text,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      textAlign: TextAlign.center,
    );
  }

  Text _buildDetails(Scripture scripture) {
    return Text(
      '${scripture.bookName} ${scripture.chapter}:${scripture.verse}',
      style: TextStyle(),
      textAlign: TextAlign.center,
    );
  }
}
