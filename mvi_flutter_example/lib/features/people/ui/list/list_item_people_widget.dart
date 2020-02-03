import 'package:flutter/material.dart';
import 'package:mvi_flutter_example/features/people/domain/model/people.dart';

class ListItemPeopleWidget extends StatelessWidget {
  final People people;
  final GestureTapCallback onTap;

  const ListItemPeopleWidget({this.people, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.people),
      title: Text(people.name),
      subtitle: Text("Birthdate: ${people.birthYear}"),
    );
  }
}
