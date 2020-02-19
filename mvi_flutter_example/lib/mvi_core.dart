import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class MviDisposable {
  Future tearDown();
}

abstract class MviView<VS> implements MviDisposable {
  final VS initialState;

  MviView({
    @required this.initialState,
  });
}

abstract class MviPartialState {}

abstract class MviStateViewModel<PS extends MviPartialState,
VS extends MviStateViewModel<PS, VS>> {
  VS reducer(PS partialState);
}

class MviPresenter<
PS extends MviPartialState,
VS extends MviStateViewModel<PS, VS>,
V extends MviView<VS>>
    implements MviDisposable {
  final StreamController<VS> controller = StreamController();
  final V view;
  VS latest;

  get viewAttached => view != null;

  get stream => controller.stream;

  MviPresenter(this.view) {
    if (this.view == null) throw ViewNotAttachedException();
    latest = view.initialState;
  }

  subscribeIntents(List<Stream<PS>> actions) {
    return viewAttached
        ? controller.addStream(merge(actions, view.initialState))
        : throw ViewNotAttachedException();
  }

  Stream<VS> merge(List<Stream<PS>> actions, VS initialState) =>
      Rx.merge(actions).distinct().scan((state, partialState, _) {
        final reducedState = state == null
            ? initialState.reducer(partialState)
            : state.reducer(partialState);

        latest = reducedState;
        return reducedState;
      });

  @mustCallSuper
  Future tearDown() => controller.close();
}

class ViewNotAttachedException implements Exception {
  @override
  String toString() =>
      'ViewNotAttachedException: View not attached';
}
