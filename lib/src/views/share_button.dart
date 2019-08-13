import 'package:bible_verse_generator/src/blocs/application_bloc.dart';
import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:bible_verse_generator/src/utilities/string.dart';

import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final ApplicationBloc bloc;
  final Scripture scripture;

  const ShareButton({
    Key key,
    @required this.bloc,
    @required this.scripture,
  })  : assert(bloc != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.share),
      onPressed: scripture != null ? null : () => _handleShare(context),
    );
  }

  _handleShare(BuildContext context) async {
    bool hasError = await bloc.handleShare(scripture);
    if (hasError)
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(shareErrorMessage),
      ));
  }
}
