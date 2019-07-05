import 'package:bible_verse_generator/src/blocs/application_bloc.dart';
import 'package:bible_verse_generator/src/utilities/string.dart';
import 'package:bible_verse_generator/src/views/my_progress_indicator.dart';
import 'package:flutter/material.dart';

class ShuffleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ApplicationBloc bloc;

  const ShuffleButton({Key key, @required this.onPressed, @required this.bloc})
      : assert(onPressed != null),
        assert(bloc != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FloatingActionButton.extended(
          onPressed: onPressed,
          tooltip: shuffleText,
          label: Text(shuffleText),
          icon: StreamBuilder<bool>(
            initialData: false,
            stream: bloc.loadingStateObservable,
            builder: (context, AsyncSnapshot<bool> snapshot) => snapshot.data
                ? MyProgressIndicator(
                    color: Colors.black,
                    size: 16,
                  )
                : Icon(Icons.shuffle),
          )),
    );
  }
}
