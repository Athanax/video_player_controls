import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seek_video_event.dart';
part 'seek_video_state.dart';

class SeekVideoBloc extends Bloc<SeekVideoEvent, SeekVideoState> {
  SeekVideoBloc() : super(SeekVideoInitial());

  @override
  Stream<SeekVideoState> mapEventToState(SeekVideoEvent event) async* {
    //
    yield SeekVideoLoading();
    if (event is SeekVideoEventLoad) {
      yield SeekVideoLoaded(event.time);
    }
  }
}
