import 'package:mvi_flutter_example/features/people/data/people_repository.dart';
import 'package:mvi_flutter_example/features/people/domain/model/mapper_from_data.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_partial_state.dart';

class PeopleInteractor {
  final PeopleRepository repository;

  PeopleInteractor(this.repository);

  Stream<PeopleListPartialState> allPeople() {
    return repository
        .peopleList()
        .where((model) => model.count > 0)
        .map((model) => PeopleListLoaded(model.people.toDomainModelList()));
  }
}
