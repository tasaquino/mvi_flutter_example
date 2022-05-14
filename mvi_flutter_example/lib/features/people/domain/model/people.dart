import 'package:meta/meta.dart';

@immutable
class People {
  final String name;
  final String birthYear;

  People({this.name, this.birthYear});
}