import 'package:mvi_flutter_example/features/people/domain/model/people.dart';
import 'package:meta/meta.dart';

@immutable
class PeopleListState {
  final bool showLoading;
  final List<People> peopleList;
  final String error;

  PeopleListState({this.showLoading, this.peopleList, this.error});

  factory PeopleListState.initial() => PeopleListState(showLoading: true);

  factory PeopleListState.error(String message) => PeopleListState(
      error: message, showLoading: false, peopleList: List<People>());

  factory PeopleListState.withList(List<People> list) => PeopleListState(
      error: null, showLoading: false, peopleList: list);

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
}
