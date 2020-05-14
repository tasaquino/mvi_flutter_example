import 'package:mvi_flutter_example/features/people/data/model/people_payload.dart';
import 'package:mvi_flutter_example/features/people/data/people_repository.dart';

import 'package:mvi_flutter_example/features/people/error_handler_transformer.dart';
import 'package:mvi_flutter_example/networking/networking_config.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final NetworkingConfig _networkingConfig;

  PeopleRepositoryImpl(this._networkingConfig);

  @override
  Stream<PeoplePayload> peopleList() {
    return Stream.fromFuture(
            _networkingConfig.dio.get('https://swapi.dev/api/people'))
        .transform(ErrorHandlerTransformer())
        .map((result) => mapPeople(result.data));
  }

  PeoplePayload mapPeople(dynamic data) {
    final results = data['results'] as List<dynamic>;

    return PeoplePayload(
      count: data['count'],
      next: data['next'],
      previous: data['previous'],
      people: results.map((result) {
        return PeoplePayloadItem(name: result['name'], birthYear: result['birth_year']);
      }).toList(),
    );
  }
}
