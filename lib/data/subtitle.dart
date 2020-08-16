import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Subtitle extends Equatable {
  final String url;
  final String title;

  Subtitle({this.url, this.title});
  @override
  //
  List<Object> get props => [url, title];
}
