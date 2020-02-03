import 'package:mvi_flutter_example/features/people/data/model/people_payload.dart';
import 'package:mvi_flutter_example/features/people/domain/model/people.dart'
    as domain;

extension PeopleMapper on List<People> {
  List<domain.People> toDomainModelList() {
    final list = List<domain.People>();
    this.forEach((p) {
      list.add(domain.People(name: p.name, birthYear: p.birthYear));
    });

    return list;
  }
}
