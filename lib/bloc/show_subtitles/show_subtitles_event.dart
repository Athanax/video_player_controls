part of 'show_subtitles_bloc.dart';

abstract class ShowSubtitlesEvent extends Equatable {
  const ShowSubtitlesEvent();
}

class ShowSubtitlesEventLoad extends ShowSubtitlesEvent {
  const ShowSubtitlesEventLoad();
  @override
  //
  List<Object> get props => [];
}
