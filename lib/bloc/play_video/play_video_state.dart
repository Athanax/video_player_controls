part of 'play_video_bloc.dart';

abstract class PlayVideoState extends Equatable {
  const PlayVideoState();
}

class PlayVideoInitial extends PlayVideoState {
  const PlayVideoInitial();
  @override
  List<Object> get props => [];
}

class PlayVideoLoading extends PlayVideoState {
  const PlayVideoLoading();
  @override
  List<Object> get props => [];
}

class PlayVideoLoaded extends PlayVideoState {
  const PlayVideoLoaded();
  @override
  List<Object> get props => [];
}
