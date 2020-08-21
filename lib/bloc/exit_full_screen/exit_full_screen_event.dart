part of 'exit_full_screen_bloc.dart';

abstract class ExitFullScreenEvent extends Equatable {
  const ExitFullScreenEvent();
}

class ExitFullScreenEventLoad extends ExitFullScreenEvent {
  const ExitFullScreenEventLoad();
  @override
  //
  List<Object> get props => [];
}
