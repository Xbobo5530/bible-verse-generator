import 'package:bible_verse_generator/src/blocs/application_bloc.dart';
import 'package:bible_verse_generator/src/views/info_button.dart';
import 'package:bible_verse_generator/src/views/scripture_view.dart';
import 'package:bible_verse_generator/src/views/share_button.dart';
import 'package:bible_verse_generator/src/views/shuffle_button.dart';
import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApplicationBloc _bloc = ApplicationBloc();

    final _shuffleButton = ShuffleButton(
        bloc: _bloc,
        onPressed: () {
          _bloc.getRandomBackgroundColors();
          _bloc.fetchScripture();
        });
    final _infoButton = InfoButton(
      bloc: _bloc,
    );
    final _colorButton = FloatingActionButton(
      child: Icon(Icons.color_lens),
      onPressed: () => _bloc.updateBackgroundColor(),
    );
    final _buttons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _infoButton,
        _shuffleButton,
        _colorButton,
        StreamBuilder<Scripture>(
            stream: _bloc.scriptureObservable,
            builder: (context, snapshot) =>
                ShareButton(bloc: _bloc, scripture: snapshot.data))
      ],
    );

    return StreamBuilder<Color>(
      stream: _bloc.randomColorsObservable,
      builder: (BuildContext context, AsyncSnapshot<Color> snapshot) =>
          Scaffold(
        backgroundColor: snapshot.data,
        body: Center(
            child: StreamBuilder<Scripture>(
          stream: _bloc.scriptureObservable,
          builder: (_, AsyncSnapshot<Scripture> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Center(
              child: ScriptureView(
                scripture: snapshot.data,
              ),
            ); //_buildCard(context, snapshot.data);
          },
        )),
        floatingActionButton: _buttons,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
