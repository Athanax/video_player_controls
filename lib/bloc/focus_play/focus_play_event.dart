part of 'focus_play_bloc.dart';

abstract class FocusPlayEvent extends Equatable {
  const FocusPlayEvent();

  @override
  List<Object> get props => [];
}

class FocusPlayEventLoad extends FocusPlayEvent {
  //
  const FocusPlayEventLoad();
}
