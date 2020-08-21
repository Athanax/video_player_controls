part of 'seek_video_bloc.dart';

abstract class SeekVideoEvent extends Equatable {
  const SeekVideoEvent();
}

class SeekVideoEventLoad extends SeekVideoEvent {
  final Duration time;
  const SeekVideoEventLoad(this.time);
  @override
  //
  List<Object> get props => [time];
}
