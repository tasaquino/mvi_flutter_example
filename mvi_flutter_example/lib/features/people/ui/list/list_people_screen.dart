import 'package:flutter/material.dart';
import 'package:mvi_flutter_example/dependency_injector.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_presenter.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_state.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_view.dart';
import 'package:mvi_flutter_example/features/people/ui/list/list_people_widget.dart';
import 'package:mvi_flutter_example/mvi_core.dart';

class ListPeoplePage extends StatefulWidget {
  final MviPresenter<PeopleListState> Function(PeopleListView) initPresenter;

  ListPeoplePage({Key key, this.initPresenter}) : super(key: key);

  @override
  _ListPeoplePageState createState() => _ListPeoplePageState();
}

class _ListPeoplePageState extends State<ListPeoplePage> with PeopleListView {
  PeopleListPresenter presenter;

  @override
  void didChangeDependencies() {
    presenter = widget.initPresenter != null
        ? widget.initPresenter(this)
        : PeopleListPresenter(
            view: this, interactor: Injector.of(context).peopleInteractor);
    presenter.bind();
    presenter.loadPeopleList();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tearDown(); // from PeopleListView
    presenter.tearDown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PeopleListState>(
      stream: presenter,
      initialData: presenter.latest,
      builder: (context, peopleState) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Star Wars: People"),
          ),
          body: Center(
              child: ListPeopleWidget(
            loading: peopleState.data?.showLoading ?? true,
            people: peopleState.data?.peopleList ?? List(),
          )), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
