part of 'video_playing_bloc.dart';

abstract class VideoPlayingEvent extends Equatable {
  const VideoPlayingEvent();
}

class VideoPlayingEventLoad extends VideoPlayingEvent {
  final bool isPlaying;

  VideoPlayingEventLoad(this.isPlaying);
  @override
  //
  List<Object> get props => [isPlaying];
}
