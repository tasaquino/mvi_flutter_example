import 'package:flutter/material.dart';

class DetailPeoplePage extends StatefulWidget {
  DetailPeoplePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetailPeoplePageState createState() => _DetailPeoplePageState();
}

class _DetailPeoplePageState extends State<DetailPeoplePage> {
  //DetailPeoplePagePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You should see details of Star Wars character here',
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
