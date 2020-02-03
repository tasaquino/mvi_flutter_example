import 'package:flutter/material.dart';
import 'package:mvi_flutter_example/dependency_injector.dart';
import 'package:mvi_flutter_example/features/people/data/people_repository_impl.dart';
import 'package:mvi_flutter_example/features/people/domain/people_interactor.dart';
import 'package:mvi_flutter_example/features/people/ui/detail/detail_screen.dart';
import 'package:mvi_flutter_example/features/people/ui/list/list_people_screen.dart';
import 'package:mvi_flutter_example/networking/networking_config.dart';
import 'package:mvi_flutter_example/routes/navigation_routes.dart';

class MviApp extends StatelessWidget {
  final _peopleInteractor =
      PeopleInteractor(PeopleRepositoryImpl(NetworkingConfig()));

  @override
  Widget build(BuildContext context) {
    return Injector(
      peopleInteractor: _peopleInteractor,
      child: MaterialApp(
          title: "MVI example",
          home: ListPeoplePage(

          ),
          routes: {
            NavigationRoutes.peopleList: (context) => ListPeoplePage(),
            NavigationRoutes.peopleDetail: (context) => DetailPeoplePage()
          }),
    );
  }
}
