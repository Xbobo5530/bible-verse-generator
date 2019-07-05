import 'dart:convert';

import 'package:bible_verse_generator/src/models/scripture.dart';
import 'package:bible_verse_generator/src/utilities/string.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationBloc {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Scripture initialScripture = Scripture();
  bool initiLoadingState = false;
  BehaviorSubject<Scripture> _subjectScripture;
  BehaviorSubject<bool> _subjectLoaingState;

  Observable<Scripture> get scriptureObservable => _subjectScripture.stream;
  Observable<bool> get loadingStateObservable => _subjectLoaingState.stream;

  ApplicationBloc() {
    _subjectScripture =
        BehaviorSubject<Scripture>.seeded(this.initialScripture);
    _subjectLoaingState = BehaviorSubject<bool>.seeded(this.initiLoadingState);
    fetchScripture();
    _showDailyAtTime();
  }

  void fetchScripture() async {
    _subjectLoaingState.sink.add(true);
    final http.Response response = await http.get(randomBibleVerseUrl);
    Scripture scripture = Scripture.fromJson(json.decode(response.body)[0]);
    _subjectScripture.sink.add(scripture);
    _subjectLoaingState.sink.add(false);
  }

  void dispose() {
    _subjectScripture.close();
    _subjectLoaingState.close();
  }

  Future<void> _showDailyAtTime() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var time = Time(14, 13, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print('Notification recieved');
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      // debugPrint('notification payload: ' + payload);
      print('notification payload: $payload');
    }

    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SecondScreen(payload)),
    // );
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  Future<bool> handleShare(Scripture scripture) async {
    bool _hasError = true;
    final sharableScripture =
        '${scripture.text}\n${scripture.bookName} ${scripture.chapter}: ${scripture.verse}';
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
}
