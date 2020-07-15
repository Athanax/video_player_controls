part of 'video_position_bloc.dart';

abstract class VideoPositionEvent extends Equatable {
  const VideoPositionEvent();
}

class VideoPositionEventLoad extends VideoPositionEvent {
  final int duration;

  const VideoPositionEventLoad(this.duration);
  @override
  //
  List<Object> get props => [duration];
}
