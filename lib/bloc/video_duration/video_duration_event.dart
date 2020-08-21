part of 'video_duration_bloc.dart';

abstract class VideoDurationEvent extends Equatable {
  const VideoDurationEvent();
}

class VideoDurationEventLoad extends VideoDurationEvent {
  final int duration;

  VideoDurationEventLoad(this.duration);
  @override
  //
  List<Object> get props => [duration];
}
