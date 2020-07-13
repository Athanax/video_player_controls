import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'previous_video_event.dart';
part 'previous_video_state.dart';

class PreviousVideoBloc extends Bloc<PreviousVideoEvent, PreviousVideoState> {
  PreviousVideoBloc() : super(PreviousVideoInitial());

  @override
  Stream<PreviousVideoState> mapEventToState(PreviousVideoEvent event) async* {
    //
    yield PreviousVideoLoading();
    if (event is PreviousVideoEventLoad) {
      yield PreviousVideoLoaded();
    }
  }
}
