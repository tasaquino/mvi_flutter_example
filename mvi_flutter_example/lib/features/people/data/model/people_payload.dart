import 'package:meta/meta.dart';

class PeoplePayload {
  final int count;
  final String next;
  final String previous;
  final List<People> people;

  PeoplePayload({this.count, this.next, this.previous, this.people});
}

@immutable
class People {
  final String name;
  final String birthYear;

  People({this.name, this.birthYear});
}
