import 'package:meta/meta.dart';

class PeoplePayload {
  final int count;
  final String next;
  final String previous;
  final List<PeoplePayloadItem> people;

  PeoplePayload({this.count, this.next, this.previous, this.people});
}

@immutable
class PeoplePayloadItem {
  final String name;
  final String birthYear;

  PeoplePayloadItem({this.name, this.birthYear});
}
