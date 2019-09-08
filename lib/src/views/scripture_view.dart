import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:flutter/material.dart';

class ScriptureView extends StatelessWidget {
  final Scripture scripture;

  const ScriptureView({Key key, @required this.scripture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _backgroundSize = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: _backgroundSize,
        width: _backgroundSize,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              title: _buildMainText(scripture),
              subtitle: _buildDetails(scripture),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildMainText(Scripture scripture) {
    return Text(
      scripture.text,
      style: TextStyle(fontWeight: FontWeight.w200, fontSize: 24),
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
