import 'package:meta/meta.dart';
import 'package:mvi_flutter_example/mvi_core.dart';
import 'package:mvi_flutter_example/features/people/domain/people_interactor.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_state.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_view.dart';
import 'package:rxdart/rxdart.dart';

class PeopleListPresenter extends MviPresenter<PeopleListState> {
  final PeopleListView _view;
  final PeopleInteractor _interactor;

  PeopleListPresenter({
    @required PeopleListView view,
    @required PeopleInteractor interactor,
  })  : _view = view,
        _interactor = interactor,
        super(
            initialModel: PeopleListState.initial(),
            stream: _buildStream(view, interactor));

  static Stream<PeopleListState> _buildStream(
      PeopleListView view, PeopleInteractor interactor) {
    return interactor.allPeople().map((list) {
      return PeopleListState.withList(list);
    }).doOnError((error, stacktrace) {
      print('ERROR::$error STACKTRACE:: $stacktrace');
      mapError(error);
    });
  }

  static PeopleListState mapError(Exception e) {
    return PeopleListState.error(e.toString());
  }

  @override
  void bind() {
    subscriptions.addAll([
      _view.fetchPeople.stream.listen((data) => _interactor.allPeople()),
    ]);

    super.bind();
  }

  void loadPeopleList() {
    _view.fetchPeople.add(true);
  }
}
