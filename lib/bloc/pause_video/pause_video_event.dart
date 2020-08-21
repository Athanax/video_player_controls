part of 'pause_video_bloc.dart';

abstract class PauseVideoEvent extends Equatable {
  const PauseVideoEvent();
}

class PauseVideoEventLoad extends PauseVideoEvent {
  const PauseVideoEventLoad();
  @override
  //
  List<Object> get props => [];
}
