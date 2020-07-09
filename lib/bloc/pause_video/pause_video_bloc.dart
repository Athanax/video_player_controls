import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pause_video_event.dart';
part 'pause_video_state.dart';

class PauseVideoBloc extends Bloc<PauseVideoEvent, PauseVideoState> {
  PauseVideoBloc() : super(PauseVideoInitial());

  @override
  Stream<PauseVideoState> mapEventToState(PauseVideoEvent event) async* {
    //
    yield PauseVideoLoading();
    if (event is PauseVideoEventLoad) {
      yield PauseVideoLoaded();
    }
  }
}
