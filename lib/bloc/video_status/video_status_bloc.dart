import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_status_event.dart';
part 'video_status_state.dart';

class VideoStatusBloc extends Bloc<VideoStatusEvent, VideoStatusState> {
  VideoStatusBloc() : super(VideoStatusInitial());

  @override
  Stream<VideoStatusState> mapEventToState(VideoStatusEvent event) async* {
    //
    if (event is VideoStatusEventPlaying) {
      yield VideoStatusPlaying();
    } else if (event is VideoStatusEventPaused) {
      yield VideoStatusPaused();
    }
  }
}
