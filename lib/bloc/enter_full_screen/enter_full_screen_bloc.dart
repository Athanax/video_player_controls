import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'enter_full_screen_event.dart';
part 'enter_full_screen_state.dart';

class EnterFullScreenBloc
    extends Bloc<EnterFullScreenEvent, EnterFullScreenState> {
  EnterFullScreenBloc() : super(EnterFullScreenInitial());

  @override
  Stream<EnterFullScreenState> mapEventToState(
      EnterFullScreenEvent event) async* {
    //
    yield EnterFullScreenLoading();
    if (event is EnterFullScreenEventLoad) {
      yield EnterFullScreenLoaded();
    }
  }
}
