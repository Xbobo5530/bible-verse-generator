import 'dart:convert';
import 'dart:math';
import 'package:bible_verse_generator/src/models/random_colors.dart';
import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:bible_verse_generator/src/utilities/hex_colors.dart';
import 'package:bible_verse_generator/src/utilities/string.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationBloc {
  Scripture initialScripture = Scripture();
  bool initiLoadingState = false;
  BehaviorSubject<Scripture> _subjectScripture;
  BehaviorSubject<bool> _subjectLoaingState;
  BehaviorSubject<Color> _subjectRandomColor;

  Observable<Scripture> get scriptureObservable => _subjectScripture.stream;
  Observable<Color> get randomColorsObservable => _subjectRandomColor.stream;
  Observable<bool> get loadingStateObservable => _subjectLoaingState.stream;

  ApplicationBloc() {
    _subjectScripture =
        BehaviorSubject<Scripture>.seeded(this.initialScripture);
    _subjectLoaingState = BehaviorSubject<bool>.seeded(this.initiLoadingState);
    fetchScripture();
    getRandomBackgroundColors();
    _subjectRandomColor = BehaviorSubject<Color>.seeded(Colors.white);
  }

  void fetchScripture() async {
    _subjectLoaingState.sink.add(true);
    final http.Response response = await http.get(RANDOM_BIBLE_VERSE_API_URL);
    Scripture scripture = Scripture.fromJson(json.decode(response.body)[0]);
    _subjectScripture.sink.add(scripture);
    _subjectLoaingState.sink.add(false);
  }

  void dispose() {
    _subjectScripture.close();
    _subjectLoaingState.close();
  }

  Future<bool> handleShare(Scripture scripture) async {
    bool _hasError = true;
    final sharableScripture =
        '${scripture.text}\n${scripture.bookName} ${scripture.chapter}: ${scripture.verse}\n$APP_DOWNLOAD_URL';
    await Share.share(sharableScripture).catchError((error) {
      print(error);
      _hasError = true;
    });
    return _hasError;
  }

  Future<bool> handleUrl(String url) async {
    bool _hasError = false;

    await launch(url).catchError((error) {
      print('cannot launch url $url');
      _hasError = true;
    });
    return _hasError;
  }

  Future getRandomBackgroundColors() async {
    bool _hasError = false;

    http.Response response =
        await http.get(RANDOM_COLORS_API_URL).catchError((error) {
      print('error on fetchin random colors: $error');
      _hasError = true;
    });
    if (_hasError) return;
    RandomColors randomColors =
        RandomColors.fromJson(json.decode(response.body));
    final random = Random();
    final String colorHexValue =
        randomColors.hex[random.nextInt(randomColors.hex.length)];
    Color randomColor;

    if (colorHexValue.length == 0)
      randomColor = Colors.white;
    else
      randomColor = HexColor(colorHexValue);

    _subjectRandomColor.add(randomColor);
  }
}
