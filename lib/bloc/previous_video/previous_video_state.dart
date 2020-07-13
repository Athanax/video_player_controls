part of 'previous_video_bloc.dart';

abstract class PreviousVideoState extends Equatable {
  const PreviousVideoState();
}

class PreviousVideoInitial extends PreviousVideoState {
  const PreviousVideoInitial();
  @override
  List<Object> get props => [];
}

class PreviousVideoLoading extends PreviousVideoState {
  const PreviousVideoLoading();
  @override
  List<Object> get props => [];
}

class PreviousVideoLoaded extends PreviousVideoState {
  const PreviousVideoLoaded();
  @override
  List<Object> get props => [];
}
