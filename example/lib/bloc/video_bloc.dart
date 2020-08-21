import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial());

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    //
    yield VideoLoading();
    if (event is VideoEventLoad) {
      yield VideoLoaded(event.pos);
    }
  }
}
