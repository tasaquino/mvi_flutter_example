import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mvi_flutter_example/features/common_widgets/loading_widget.dart';
import 'package:mvi_flutter_example/features/people/domain/model/people.dart';
import 'package:mvi_flutter_example/features/people/ui/detail/detail_screen.dart';
import 'package:mvi_flutter_example/features/people/ui/list/people_list_item_widget.dart';

class PeopleListWidget extends StatelessWidget {
  static final peopleListKey = Key("people_list_key");
  static final snackKey = Key("snackbar_key");

  final bool loading;
  final List<People> people;

  const PeopleListWidget({
    Key key,
    @required this.loading,
    @required this.people,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading ? LoadingWidget() : _buildList(people);
  }

  _buildList(List<People> people) => ListView.builder(
        key: peopleListKey,
        itemCount: people.length,
        itemBuilder: (context, index) {
          final p = people[index];
          return PeopleListItemWidget(
              people: p,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => DetailPeoplePage()))
                    .then((people) {
                  if (people is People) {
                    final snackBar = SnackBar(
                        key: snackKey,
                        duration: Duration(seconds: 2),
                        content: Text("Details of: ${people.name}"));

                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                });
              });
        },
      );
}
