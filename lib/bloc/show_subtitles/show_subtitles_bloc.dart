import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_subtitles_event.dart';
part 'show_subtitles_state.dart';

class ShowSubtitlesBloc extends Bloc<ShowSubtitlesEvent, ShowSubtitlesState> {
  ShowSubtitlesBloc() : super(ShowSubtitlesInitial());

  @override
  Stream<ShowSubtitlesState> mapEventToState(ShowSubtitlesEvent event) async* {
    //
    yield ShowSubtitlesLoading();
    if (event is ShowSubtitlesEventLoad) {
      yield ShowSubtitlesLoaded();
    }
  }
}
