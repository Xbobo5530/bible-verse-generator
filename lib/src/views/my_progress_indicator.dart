import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;

  /// A [double] value [value] that shows the value to be displayed
  /// by the determinent [CircularProgressIndicator]
  final double value;
  final double strokeWidth;

  /// Whether the [CircularProgressIndicator] should appear
  /// at the center of the [Container] or outside the [Container]
  /// by default the indicator appears outside the container
  final bool isCentered;

  const MyProgressIndicator(
      {Key key,
      this.size = 36.0,
      this.color,
      this.value,
      this.strokeWidth = 2,
      this.isCentered = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _progressIndicator = CircularProgressIndicator(
      value: value,
      strokeWidth: strokeWidth,
    );
    return Container(
        width: size,
        height: size,
        child: Theme(
          child: isCentered
              ? Center(
                  child: _progressIndicator,
                )
              : _progressIndicator,
          data: Theme.of(context).copyWith(accentColor: color),
        ));
  }
}
