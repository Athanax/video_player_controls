part of 'fast_foward_bloc.dart';

abstract class FastFowardEvent extends Equatable {
  const FastFowardEvent();
}

class FastFowardEventLoad extends FastFowardEvent {
  const FastFowardEventLoad();
  @override
  //
  List<Object> get props => [];
}
