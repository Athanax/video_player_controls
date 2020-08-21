part of 'fast_rewind_bloc.dart';

abstract class FastRewindEvent extends Equatable {
  const FastRewindEvent();
}

class FastRewindEventLoad extends FastRewindEvent {
  const FastRewindEventLoad();
  @override
  //
  List<Object> get props => [];
}
