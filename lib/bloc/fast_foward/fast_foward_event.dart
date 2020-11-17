part of 'fast_foward_bloc.dart';

abstract class FastFowardEvent extends Equatable {
  const FastFowardEvent();
}

class FastFowardEventLoad extends FastFowardEvent {
  final int seconds;
  const FastFowardEventLoad(this.seconds);
  @override
  //
  List<Object> get props => [];
}
