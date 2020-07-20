part of 'video_duration_bloc.dart';

abstract class VideoDurationState extends Equatable {
  const VideoDurationState();
}

class VideoDurationInitial extends VideoDurationState {
  const VideoDurationInitial();
  @override
  List<Object> get props => [];
}

class VideoDurationLoading extends VideoDurationState {
  const VideoDurationLoading();
  @override
  List<Object> get props => [];
}

class VideoDurationLoaded extends VideoDurationState {
  final int duration;
  const VideoDurationLoaded(this.duration);
  @override
  List<Object> get props => [duration];
}
