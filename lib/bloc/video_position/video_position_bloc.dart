import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_position_event.dart';
part 'video_position_state.dart';

class VideoPositionBloc extends Bloc<VideoPositionEvent, VideoPositionState> {
  VideoPositionBloc() : super(VideoPositionInitial());

  @override
  Stream<VideoPositionState> mapEventToState(VideoPositionEvent event) async* {
    //
    yield VideoPositionLoading();
    if (event is VideoPositionEventLoad) {
      print('Position ' + event.duration.inSeconds.toString());
      yield VideoPositionLoaded(event.duration);
    }
  }
}
