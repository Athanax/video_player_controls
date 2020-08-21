part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();
}

class VideoEventLoad extends VideoEvent {
  final int pos;
  const VideoEventLoad(this.pos);
  @override
  //
  List<Object> get props => [pos];
}
