import 'package:bible_verse_generator/src/blocs/application_bloc.dart';
import 'package:bible_verse_generator/src/utilities/string.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class InfoButton extends StatelessWidget {
  final ApplicationBloc bloc;

  const InfoButton({Key key, @required this.bloc})
      : assert(bloc != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.info),
      onPressed: () => _showInfoDialog(context),
    );
  }

  _showInfoDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => _buildAlertDialog());
  }

  _buildAlertDialog() => FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
          final callButton = FlatButton(
            child: Text(callText),
            onPressed: () => bloc.handleUrl(PHONE_URL),
          );

          final emailBUtton = FlatButton(
            child: Text(emailText),
            onPressed: () => bloc.handleUrl(EMAIL_URL),
          );

          final whatsappButton = FlatButton(
            child: Text(whatsappText),
            onPressed: () => bloc.handleUrl(WHATSAPP_URL),
          );

          if (!snapshot.hasData)
            return Center(
              child: Wrap(
                children: <Widget>[CircularProgressIndicator()],
              ),
            );

          return AlertDialog(
            title: Text(snapshot.data.appName),
            content: ListTile(
              title: Text(developedByText),
            ),
            actions: <Widget>[callButton, emailBUtton, whatsappButton],
          );
        },
      );
}
