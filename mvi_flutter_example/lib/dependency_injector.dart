import 'package:flutter/widgets.dart';
import 'package:mvi_flutter_example/features/people/domain/people_interactor.dart';

class Injector extends InheritedWidget {
  final PeopleInteractor peopleInteractor;

  Injector({
    Key key,
    @required this.peopleInteractor,
    @required Widget child,
  }) : super(key: key, child: child);

  static Injector of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(Injector oldWidget) {
    return peopleInteractor != oldWidget.peopleInteractor;
  }
}
