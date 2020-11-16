part of 'fast_rewind_bloc.dart';

abstract class FastRewindEvent extends Equatable {
  const FastRewindEvent();
}

class FastRewindEventLoad extends FastRewindEvent {
  final int seconds;
  const FastRewindEventLoad(this.seconds);
  @override
  //
  List<Object> get props => [];
}
