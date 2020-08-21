part of 'video_playing_bloc.dart';

abstract class VideoPlayingState extends Equatable {
  const VideoPlayingState();
}

class VideoPlayingInitial extends VideoPlayingState {
  const VideoPlayingInitial();
  @override
  List<Object> get props => [];
}

class VideoPlayingLoading extends VideoPlayingState {
  const VideoPlayingLoading();
  @override
  List<Object> get props => [];
}

class VideoPlayingLoaded extends VideoPlayingState {
  final bool isPlaying;
  const VideoPlayingLoaded(this.isPlaying);
  @override
  List<Object> get props => [isPlaying];
}
