part of 'play_video_bloc.dart';

abstract class PlayVideoEvent extends Equatable {
  const PlayVideoEvent();
}

class PlayVideoEventLoad extends PlayVideoEvent {
  const PlayVideoEventLoad();
  @override
  //
  List<Object> get props => [];
}
