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

    final _shuffleButton =
        ShuffleButton(bloc: _bloc, onPressed: () => _bloc.fetchScripture());

    // final _previousButton = FloatingActionButton(
    //     child: Icon(Icons.skip_previous), onPressed: _goToPReviousVerse());
    final _infoButton = InfoButton(
      bloc: _bloc,
    );
    final _buttons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _infoButton,
        _shuffleButton,
        StreamBuilder<Scripture>(
            stream: _bloc.scriptureObservable,
            builder: (context, snapshot) =>
                ShareButton(bloc: _bloc, scripture: snapshot.data))
      ],
    );

    return Scaffold(
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(16),
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
              ))),
      floatingActionButton: _buttons,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // _goToPReviousVerse() {
  //   //TODO: handle go to previous verse
  //   /// create an array from which the [Card] will be fetching the verse from
  //   /// or show previous verse can just check what the previous verse was on the array
  //   /// when previous verse is shown maybe show the next action button
  // }
}
