part of 'video_position_bloc.dart';

abstract class VideoPositionEvent extends Equatable {
  const VideoPositionEvent();
}

class VideoPositionEventLoad extends VideoPositionEvent {
  final Duration duration;

  const VideoPositionEventLoad(this.duration);
  @override
  //
  List<Object> get props => [duration];
}
