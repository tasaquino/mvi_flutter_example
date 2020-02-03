import 'package:mvi_flutter_example/features/people/domain/model/people.dart';
import 'package:mvi_flutter_example/features/people/data/people_repository.dart';
import 'package:mvi_flutter_example/features/people/domain/model/mapper_from_data.dart';

class PeopleInteractor {
  final PeopleRepository repository;

  PeopleInteractor(this.repository);

  Stream<List<People>> allPeople() {
    return repository
        .peopleList()
        .where((model) => model.count > 0)
        .map((model) => model.people.toDomainModelList());
  }
}
