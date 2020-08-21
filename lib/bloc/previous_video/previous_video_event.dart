part of 'previous_video_bloc.dart';

abstract class PreviousVideoEvent extends Equatable {
  const PreviousVideoEvent();
}

class PreviousVideoEventLoad extends PreviousVideoEvent {
  const PreviousVideoEventLoad();
  @override
  //
  List<Object> get props => [];
}
