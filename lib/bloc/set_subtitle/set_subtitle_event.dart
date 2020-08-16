part of 'set_subtitle_bloc.dart';

abstract class SetSubtitleEvent extends Equatable {
  const SetSubtitleEvent();
}

class SetSubtitleEventLoad extends SetSubtitleEvent {
  final Subtitle subtitle;

  SetSubtitleEventLoad(this.subtitle);
  @override
  //
  List<Object> get props => [subtitle];
}
