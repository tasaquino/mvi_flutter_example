import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class MviDisposable {
  Future tearDown();
}

abstract class MviView implements MviDisposable {}

class MviPresenter<VS> extends Stream<VS> implements MviDisposable {
  final BehaviorSubject<VS> _subject;
  final List<StreamSubscription<dynamic>> subscriptions = [];

  MviPresenter({
    @required Stream<VS> stream,
    VS initialModel,
  }) : _subject = _createSubject<VS>(stream, initialModel);

  VS get latest => _subject.value;

  void bind() {}

  static _createSubject<VS>(
    Stream<VS> model,
    VS initialState,
  ) {
    StreamSubscription<VS> subscription;
    BehaviorSubject<VS> _subject;
    void onListen() {
      subscription = model.listen(_subject.add,
          onError: _subject.addError, onDone: _subject.close);
    }

    void onCancel() => subscription.cancel();

    _subject = initialState == null
        ? BehaviorSubject<VS>(
            onListen: onListen, onCancel: onCancel, sync: true)
        : BehaviorSubject<VS>.seeded(initialState,
            onListen: onListen, onCancel: onCancel);

    return _subject;
  }

  @override
  StreamSubscription<VS> listen(void Function(VS event) onData,
      {Function onError, void Function() onDone, bool cancelOnError}) {
    return _subject.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  @mustCallSuper
  Future tearDown() => Future.wait(
      [_subject.close()]..addAll(subscriptions.map((s) => s.cancel())));
}
