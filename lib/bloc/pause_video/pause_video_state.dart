part of 'pause_video_bloc.dart';

abstract class PauseVideoState extends Equatable {
  const PauseVideoState();
}

class PauseVideoInitial extends PauseVideoState {
  const PauseVideoInitial();
  @override
  List<Object> get props => [];
}

class PauseVideoLoading extends PauseVideoState {
  const PauseVideoLoading();
  @override
  List<Object> get props => [];
}

class PauseVideoLoaded extends PauseVideoState {
  const PauseVideoLoaded();
  @override
  List<Object> get props => [];
}
