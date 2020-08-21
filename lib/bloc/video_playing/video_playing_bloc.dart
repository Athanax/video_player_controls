import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_playing_event.dart';
part 'video_playing_state.dart';

class VideoPlayingBloc extends Bloc<VideoPlayingEvent, VideoPlayingState> {
  VideoPlayingBloc() : super(VideoPlayingInitial());

  @override
  Stream<VideoPlayingState> mapEventToState(VideoPlayingEvent event) async* {
    //
    yield VideoPlayingLoading();
    if (event is VideoPlayingEventLoad) {
      yield VideoPlayingLoaded(event.isPlaying);
    }
  }
}
