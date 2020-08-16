part of 'set_subtitle_bloc.dart';

abstract class SetSubtitleState extends Equatable {
  const SetSubtitleState();
}

class SetSubtitleInitial extends SetSubtitleState {
  const SetSubtitleInitial();
  @override
  List<Object> get props => [];
}

class SetSubtitleLoading extends SetSubtitleState {
  const SetSubtitleLoading();
  @override
  List<Object> get props => [];
}

class SetSubtitleLoaded extends SetSubtitleState {
  final Subtitle subtitle;
  const SetSubtitleLoaded(this.subtitle);
  @override
  List<Object> get props => [subtitle];
}
