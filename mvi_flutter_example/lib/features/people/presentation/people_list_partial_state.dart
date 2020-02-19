import 'package:mvi_flutter_example/features/people/domain/model/people.dart';
import 'package:mvi_flutter_example/mvi_core.dart';

class PeopleListPartialState extends MviPartialState {}

class PeopleListLoaded extends PeopleListPartialState {
  List<People> people;

  PeopleListLoaded(this.people);
}

class PeopleListFailed extends PeopleListPartialState {}

class PeopleListLoading extends PeopleListPartialState {}
