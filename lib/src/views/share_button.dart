import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatefulWidget {
  final Scripture scripture;

  const ShareButton({Key key, @required this.scripture}) : super(key: key);
  @override
  _ShareButtonState createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.share),
      onPressed: widget.scripture == null ? null : () => _handleShare(),
    );
  }

  _handleShare() {
    //TODO: handle share
    ///add share package to project
    ///add the share function here
    ///the widget is stateless to be able to handle errors
    ///for when share returns an error
  }
}
