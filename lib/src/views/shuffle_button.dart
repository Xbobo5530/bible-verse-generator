import 'package:bible_verse_generator/src/utilities/string.dart';
import 'package:bible_verse_generator/src/views/my_progress_indicator.dart';
import 'package:flutter/material.dart';

class ShuffleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const ShuffleButton(
      {Key key, @required this.onPressed, this.isLoading = false})
      : assert(onPressed != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        tooltip: shuffleText,
        label: Text(shuffleText),
        icon: isLoading
            ? MyProgressIndicator(
                color: Colors.black,
                size: 16,
              )
            : Icon(Icons.shuffle),
      ),
    );
  }
}
