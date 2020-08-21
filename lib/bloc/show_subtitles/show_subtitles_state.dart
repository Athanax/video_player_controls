part of 'show_subtitles_bloc.dart';

abstract class ShowSubtitlesState extends Equatable {
  const ShowSubtitlesState();
}

class ShowSubtitlesInitial extends ShowSubtitlesState {
  const ShowSubtitlesInitial();
  @override
  List<Object> get props => [];
}

class ShowSubtitlesLoading extends ShowSubtitlesState {
  const ShowSubtitlesLoading();
  @override
  List<Object> get props => [];
}

class ShowSubtitlesLoaded extends ShowSubtitlesState {
  const ShowSubtitlesLoaded();
  @override
  List<Object> get props => [];
}
