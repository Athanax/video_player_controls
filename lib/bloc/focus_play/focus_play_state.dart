part of 'focus_play_bloc.dart';

abstract class FocusPlayState extends Equatable {
  const FocusPlayState();

  @override
  List<Object> get props => [];
}

class FocusPlayInitial extends FocusPlayState {
  const FocusPlayInitial();
}

class FocusPlayLoading extends FocusPlayState {
  const FocusPlayLoading();
}

class FocusPlayLoaded extends FocusPlayState {
  const FocusPlayLoaded();
}
