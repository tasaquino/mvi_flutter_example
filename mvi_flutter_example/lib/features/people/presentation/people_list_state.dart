import 'package:mvi_flutter_example/features/people/domain/model/people.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_partial_state.dart';
import 'package:mvi_flutter_example/mvi_core.dart';

class PeopleListState
    extends MviStateViewModel<PeopleListPartialState, PeopleListState> {
  final bool showLoading;
  final List<People> peopleList;
  final String error;

  PeopleListState({this.showLoading, this.peopleList, this.error});

  factory PeopleListState.initial() => PeopleListState(showLoading: true);

  factory PeopleListState.error(String message) => PeopleListState(
      error: message, showLoading: false);

  factory PeopleListState.withList(List<People> list) =>
      PeopleListState(error: null, showLoading: false, peopleList: list);

  @override
  String toString() {
    return 'PeopleListState {showLoading: $showLoading, peopleList: $peopleList, error: $error}';
  }

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        other is PeopleListState &&
            showLoading == other.showLoading &&
            peopleList == other.peopleList &&
            error == other.error;
  }

  @override
  int get hashCode =>
      showLoading.hashCode ^ peopleList.hashCode ^ error.hashCode;

  @override
  PeopleListState reducer(PeopleListPartialState partialState) {
    switch (partialState.runtimeType) {
      case PeopleListLoaded:
        return PeopleListState.withList(
            (partialState as PeopleListLoaded)?.people);
      case PeopleListFailed:
        return PeopleListState.error('Unable to load people list');
      default:
        return PeopleListState.initial();
    }
  }
}