part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();
}

class VideoInitial extends VideoState {
  const VideoInitial();
  @override
  List<Object> get props => [];
}

class VideoLoading extends VideoState {
  const VideoLoading();
  @override
  List<Object> get props => [];
}

class VideoLoaded extends VideoState {
  final int pos;
  const VideoLoaded(this.pos);
  @override
  List<Object> get props => [pos];
}
