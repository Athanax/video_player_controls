import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'play_video_event.dart';
part 'play_video_state.dart';

class PlayVideoBloc extends Bloc<PlayVideoEvent, PlayVideoState> {
  PlayVideoBloc() : super(PlayVideoInitial());

  @override
  Stream<PlayVideoState> mapEventToState(PlayVideoEvent event) async* {
    //
    yield PlayVideoLoading();
    if (event is PlayVideoEventLoad) {
      yield PlayVideoLoaded();
    }
  }
}
