part of 'fast_rewind_bloc.dart';

abstract class FastRewindState extends Equatable {
  const FastRewindState();
}

class FastRewindInitial extends FastRewindState {
  const FastRewindInitial();
  @override
  List<Object> get props => [];
}

class FastRewindLoading extends FastRewindState {
  const FastRewindLoading();
  @override
  List<Object> get props => [];
}

class FastRewindLoaded extends FastRewindState {
  final int seconds;
  const FastRewindLoaded(this.seconds);
  @override
  List<Object> get props => [];
}
