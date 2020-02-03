import 'package:mvi_flutter_example/features/people/data/model/people_payload.dart';

abstract class PeopleRepository{
  Stream<PeoplePayload> peopleList();
}