import 'package:mockito/mockito.dart';
import 'package:mvi_flutter_example/features/people/data/people_repository.dart';
import 'package:mvi_flutter_example/features/people/domain/people_interactor.dart';
import 'package:mvi_flutter_example/features/people/presentation/people_list_presenter.dart';

class MockPeopleListInteractor extends Mock implements PeopleInteractor {}

class MockPeopleRepository extends Mock implements PeopleRepository {}

class MockPeoplePresenter extends Mock implements PeopleListPresenter {}
