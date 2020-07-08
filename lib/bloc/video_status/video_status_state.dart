part of 'video_status_bloc.dart';

abstract class VideoStatusState extends Equatable {
  const VideoStatusState();
}

class VideoStatusInitial extends VideoStatusState {
  const VideoStatusInitial();
  @override
  List<Object> get props => [];
}

class VideoStatusLoading extends VideoStatusState {
  const VideoStatusLoading();
  @override
  List<Object> get props => [];
}

class VideoStatusPlaying extends VideoStatusState {
  const VideoStatusPlaying();
  @override
  List<Object> get props => [];
}

class VideoStatusPaused extends VideoStatusState {
  const VideoStatusPaused();
  @override
  List<Object> get props => [];
}
