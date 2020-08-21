import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_duration_event.dart';
part 'video_duration_state.dart';

class VideoDurationBloc extends Bloc<VideoDurationEvent, VideoDurationState> {
  VideoDurationBloc() : super(VideoDurationInitial());

  @override
  Stream<VideoDurationState> mapEventToState(VideoDurationEvent event) async* {
    //
    yield VideoDurationLoading();
    if (event is VideoDurationEventLoad) {
      yield VideoDurationLoaded(event.duration);
    }
  }
}
