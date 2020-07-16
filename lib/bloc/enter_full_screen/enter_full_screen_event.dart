part of 'enter_full_screen_bloc.dart';

abstract class EnterFullScreenEvent extends Equatable {
  const EnterFullScreenEvent();
}

class EnterFullScreenEventLoad extends EnterFullScreenEvent {
  const EnterFullScreenEventLoad();
  @override
  //
  List<Object> get props => [];
}
