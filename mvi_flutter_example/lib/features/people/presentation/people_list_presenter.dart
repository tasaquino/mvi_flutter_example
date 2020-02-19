import 'package:meta/meta.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_partial_state.dart';
import 'package:mvi_flutter_example/mvi_core.dart';
import 'package:mvi_flutter_example/features/people/domain/people_interactor.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_state.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_view.dart';
import 'package:rxdart/rxdart.dart';

class PeopleListPresenter extends MviPresenter<PeopleListPartialState,
    PeopleListState, PeopleListView> {
  final PeopleListView _view;
  final PeopleInteractor _interactor;

  PeopleListPresenter({
    @required PeopleListView view,
    @required PeopleInteractor interactor,
  })  : _view = view,
        _interactor = interactor,
        super(view) {
    subscribeIntents([_load()]);
  }

  Stream<PeopleListPartialState> _load() =>
      _view.fetchPeople.stream.flatMap((_) => _interactor
          .allPeople()
          .startWith(PeopleListLoading())
          .onErrorReturn(PeopleListFailed()));

  void triggerLoad() => _view.fetchPeople.add(true);
}
