import 'dart:async';

import 'package:mvi_flutter_example/features/people/presentation/people_list_state.dart';
import 'package:mvi_flutter_example/mvi_core.dart';

class PeopleListView implements MviView<PeopleListState> {
  final fetchPeople = StreamController<bool>.broadcast(sync: true);

  @override
  Future tearDown() {
    return Future.wait([fetchPeople.close()]);
  }

  @override

  PeopleListState get initialState => PeopleListState.initial();
}
