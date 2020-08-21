part of 'enter_full_screen_bloc.dart';

abstract class EnterFullScreenState extends Equatable {
  const EnterFullScreenState();
}

class EnterFullScreenInitial extends EnterFullScreenState {
  const EnterFullScreenInitial();
  @override
  List<Object> get props => [];
}

class EnterFullScreenLoading extends EnterFullScreenState {
  const EnterFullScreenLoading();
  @override
  List<Object> get props => [];
}

class EnterFullScreenLoaded extends EnterFullScreenState {
  const EnterFullScreenLoaded();
  @override
  List<Object> get props => [];
}
