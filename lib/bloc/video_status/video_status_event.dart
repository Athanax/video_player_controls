part of 'video_status_bloc.dart';

abstract class VideoStatusEvent extends Equatable {
  const VideoStatusEvent();
}

class VideoStatusEventPaused extends VideoStatusEvent {
  const VideoStatusEventPaused();
  @override
  //
  List<Object> get props => [];
}

class VideoStatusEventPlaying extends VideoStatusEvent {
  const VideoStatusEventPlaying();
  @override
  //
  List<Object> get props => [];
}
