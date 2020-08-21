part of 'next_video_bloc.dart';

abstract class NextVideoEvent extends Equatable {
  const NextVideoEvent();
}

class NextVideoEventLoad extends NextVideoEvent {
  const NextVideoEventLoad();
  @override
  //
  List<Object> get props => [];
}
