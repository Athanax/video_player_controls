part of 'next_video_bloc.dart';

abstract class NextVideoState extends Equatable {
  const NextVideoState();
}

class NextVideoInitial extends NextVideoState {
  const NextVideoInitial();
  @override
  List<Object> get props => [];
}

class NextVideoLoading extends NextVideoState {
  const NextVideoLoading();
  @override
  List<Object> get props => [];
}

class NextVideoLoaded extends NextVideoState {
  const NextVideoLoaded();
  @override
  List<Object> get props => [];
}
