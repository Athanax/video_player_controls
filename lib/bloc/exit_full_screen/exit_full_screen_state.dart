part of 'exit_full_screen_bloc.dart';

abstract class ExitFullScreenState extends Equatable {
  const ExitFullScreenState();
}

class ExitFullScreenInitial extends ExitFullScreenState {
  const ExitFullScreenInitial();
  @override
  List<Object> get props => [];
}

class ExitFullScreenLoading extends ExitFullScreenState {
  const ExitFullScreenLoading();
  @override
  List<Object> get props => [];
}

class ExitFullScreenLoaded extends ExitFullScreenState {
  const ExitFullScreenLoaded();
  @override
  List<Object> get props => [];
}
