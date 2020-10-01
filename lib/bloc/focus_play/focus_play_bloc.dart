import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'focus_play_event.dart';
part 'focus_play_state.dart';

class FocusPlayBloc extends Bloc<FocusPlayEvent, FocusPlayState> {
  FocusPlayBloc() : super(FocusPlayInitial());

  @override
  Stream<FocusPlayState> mapEventToState(FocusPlayEvent event) async* {
    //
    yield FocusPlayLoading();
    if (event is FocusPlayEventLoad) {
      yield FocusPlayLoaded();
    }
  }
}
