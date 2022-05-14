import 'package:flutter/material.dart';
import 'package:mvi_flutter_example/dependency_injector.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_presenter.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_state.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_view.dart';
import 'package:mvi_flutter_example/features/people/ui/list/people_list_widget.dart';

class PeopleListPage extends StatefulWidget {
  final PeopleListPresenter Function(PeopleListView) initPresenter;

  PeopleListPage({Key key, this.initPresenter}) : super(key: key);

  @override
  _PeopleListPageState createState() => _PeopleListPageState();
}

class _PeopleListPageState extends State<PeopleListPage> with PeopleListView {
  PeopleListPresenter presenter;

  @override
  void didChangeDependencies() {
    presenter = widget.initPresenter != null
        ? widget.initPresenter(this)
        : PeopleListPresenter(
            view: this, interactor: Injector.of(context).peopleInteractor);
    presenter.triggerLoad();
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
      stream: presenter.stream,
      initialData: presenter.latest,
      builder: (context, peopleState) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Star Wars: People"),
          ),
          body: Center(
              child: PeopleListWidget(
            loading: peopleState.data?.showLoading ?? true,
            people: peopleState.data?.peopleList ?? [],
          )), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
