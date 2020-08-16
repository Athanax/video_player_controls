import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player_controls/data/subtitle.dart';

part 'set_subtitle_event.dart';
part 'set_subtitle_state.dart';

class SetSubtitleBloc extends Bloc<SetSubtitleEvent, SetSubtitleState> {
  SetSubtitleBloc() : super(SetSubtitleInitial());

  @override
  Stream<SetSubtitleState> mapEventToState(SetSubtitleEvent event) async* {
    //
    yield SetSubtitleLoading();

    if (event is SetSubtitleEventLoad) {
      yield SetSubtitleLoaded(event.subtitle);
    }
  }
}
