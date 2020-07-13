part of 'fast_foward_bloc.dart';

abstract class FastFowardState extends Equatable {
  const FastFowardState();
}

class FastFowardInitial extends FastFowardState {
  const FastFowardInitial();
  @override
  List<Object> get props => [];
}

class FastFowardLoading extends FastFowardState {
  const FastFowardLoading();
  @override
  List<Object> get props => [];
}

class FastFowardLoaded extends FastFowardState {
  const FastFowardLoaded();
  @override
  List<Object> get props => [];
}
