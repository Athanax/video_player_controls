part of 'video_position_bloc.dart';

abstract class VideoPositionState extends Equatable {
  const VideoPositionState();
}

class VideoPositionInitial extends VideoPositionState {
  VideoPositionInitial();
  @override
  List<Object> get props => [];
}

class VideoPositionLoading extends VideoPositionState {
  VideoPositionLoading();
  @override
  List<Object> get props => [];
}

class VideoPositionLoaded extends VideoPositionState {
  final int duration;
  VideoPositionLoaded(this.duration);
  @override
  List<Object> get props => [duration];
}
