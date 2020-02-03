import 'dart:async';

import 'package:mvi_flutter_example/mvi_core.dart';

class PeopleListView implements MviView {
  final fetchPeople = StreamController<bool>.broadcast(sync: true);

  @override
  Future tearDown() {
    return Future.wait([fetchPeople.close()]);
  }
}
