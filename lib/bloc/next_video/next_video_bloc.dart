import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'next_video_event.dart';
part 'next_video_state.dart';

class NextVideoBloc extends Bloc<NextVideoEvent, NextVideoState> {
  NextVideoBloc() : super(NextVideoInitial());

  @override
  Stream<NextVideoState> mapEventToState(NextVideoEvent event) async* {
    //
    yield NextVideoLoading();
    if (event is NextVideoEventLoad) {
      yield NextVideoLoaded();
    }
  }
}
