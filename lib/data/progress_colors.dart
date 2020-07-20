import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProgressColors extends Equatable {
  final Color backgroundColor;
  final Color playedColor;

  ProgressColors({this.backgroundColor, this.playedColor = Colors.white38});
  @override
  //
  List<Object> get props => [backgroundColor, playedColor];
}
