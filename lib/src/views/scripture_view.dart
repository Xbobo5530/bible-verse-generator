import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:flutter/material.dart';

class ScriptureView extends StatefulWidget {
  final Scripture scripture;

  const ScriptureView({Key key, @required this.scripture})
      : assert(scripture != null),
        super(key: key);

  @override
  _ScriptureViewState createState() => _ScriptureViewState();
}

class _ScriptureViewState extends State<ScriptureView> {
  // GlobalKey _cardKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lime,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: _buildMainText(widget.scripture),
          subtitle: _buildDetails(widget.scripture),
        ),
      ),
    );
  }

  // double _getCardHeight() {
  //   return Random().nextDouble()*100;
  //   final RenderBox renderBoxRed = _cardKey.currentContext.findRenderObject();

  //   print('height is : ${renderBoxRed.size.height}');
  //   return renderBoxRed.size.height;
  // }

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
