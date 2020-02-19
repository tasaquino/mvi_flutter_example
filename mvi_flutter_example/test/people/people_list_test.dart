import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mvi_flutter_example/dependency_injector.dart';
import 'package:mvi_flutter_example/features/people/data/model/people_payload.dart';
import 'package:mvi_flutter_example/features/people/domain/model/people.dart';
import 'package:mvi_flutter_example/features/people/domain/people_interactor.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_partial_state.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_presenter.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_state.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mvi_flutter_example/features/people/ui/list/people_list_screen.dart';
import 'mocks.dart';

main() {
  group('People list tests', () {
    group('People view', () {
      test('Should present an initial state', () {
        final view = PeopleListView();

        view.tearDown();

        expect(view.fetchPeople.isClosed, isTrue);
      });
    });

    group('People Presenter', () {
      test('Should present loading and loaded state', () {
        final interactor = MockPeopleListInteractor();
        final view = PeopleListView();
        final presenter =
            PeopleListPresenter(view: view, interactor: interactor);

        final babyYoda = People(name: 'baby Yoda', birthYear: '0');
        final partial = PeopleListLoaded([babyYoda]);
        final statusLoading = PeopleListState.initial();
        final statusLoaded = PeopleListState.withList(partial.people);

        when(interactor.allPeople()).thenAnswer((_) => Stream.value(partial));

        presenter.triggerLoad();

        expect(presenter.stream, emitsInOrder([statusLoading, statusLoaded]));
      });

      test('Should present error state', () {
        final interactor = MockPeopleListInteractor();
        final view = PeopleListView();
        final presenter =
            PeopleListPresenter(view: view, interactor: interactor);

        final partial = PeopleListFailed();
        final statusLoading = PeopleListState.initial();
        final statusFailed =
            PeopleListState.error('Unable to load people list');

        when(interactor.allPeople()).thenAnswer((_) => Stream.value(partial));

        presenter.triggerLoad();

        expect(presenter.stream, emitsInOrder([statusLoading, statusFailed]));
      });
    });

    group('People Interactor', () {
      test('Should load people', () {
        final repository = MockPeopleRepository();
        final interactor = PeopleInteractor(repository);
        final payload = PeoplePayload(count: 3, people: [
          PeoplePayloadItem(name: "a", birthYear: '1'),
          PeoplePayloadItem(name: "a", birthYear: '2'),
          PeoplePayloadItem(name: "a", birthYear: '3')
        ]);

        when(repository.peopleList()).thenAnswer((_) => Stream.value(payload));

        interactor.allPeople().listen((emission) {
          expect(emission.runtimeType, PeopleListLoaded);
          final data = emission as PeopleListLoaded;
          expect(data.people.length, 3);
        });
      });

      test('Should load empty list', () {
        final repository = MockPeopleRepository();
        final interactor = PeopleInteractor(repository);
        final payload = PeoplePayload(count: 0, people: []);

        when(repository.peopleList()).thenAnswer((_) => Stream.value(payload));

        interactor.allPeople().listen((emission) {
          expect(emission.runtimeType, PeopleListLoaded);
          final data = emission as PeopleListLoaded;
          expect(data.people.length, 0);
        });
      });
    });

    testWidgets('People Widget', (tester) async {
      final interactor = MockPeopleListInteractor();
      final screen = Injector(
        peopleInteractor: interactor,
        child: MaterialApp(
          home: Scaffold(
            body: PeopleListPage(),
          ),
        ),
      );

      final babyYoda = People(name: 'baby Yoda', birthYear: 'X');
      final partial = PeopleListLoaded([babyYoda]);
      final data = PeopleListLoaded(partial.people);

      when(interactor.allPeople()).thenAnswer((_) => Stream.value(partial));

      await tester.pumpWidget(screen);
      await tester.pumpAndSettle();
      await tester.pump();

      expect(find.text(data.people[0].name), findsOneWidget);
    });
  });
}
