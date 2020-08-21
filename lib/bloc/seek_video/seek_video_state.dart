part of 'seek_video_bloc.dart';

abstract class SeekVideoState extends Equatable {
  const SeekVideoState();
}

class SeekVideoInitial extends SeekVideoState {
  const SeekVideoInitial();
  @override
  List<Object> get props => [];
}

class SeekVideoLoading extends SeekVideoState {
  const SeekVideoLoading();
  @override
  List<Object> get props => [];
}

class SeekVideoLoaded extends SeekVideoState {
  final Duration time;
  const SeekVideoLoaded(this.time);
  @override
  List<Object> get props => [time];
}
