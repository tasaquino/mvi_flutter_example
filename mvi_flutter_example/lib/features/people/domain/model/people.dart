import 'package:meta/meta.dart';
import 'package:mvi_flutter_example/features/people/data/model/people_payload.dart';

@immutable
class People {
  final String name;
  final String birthYear;

  People({this.name, this.birthYear});
}