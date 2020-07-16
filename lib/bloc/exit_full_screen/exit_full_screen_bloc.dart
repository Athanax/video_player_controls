import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exit_full_screen_event.dart';
part 'exit_full_screen_state.dart';

class ExitFullScreenBloc
    extends Bloc<ExitFullScreenEvent, ExitFullScreenState> {
  ExitFullScreenBloc() : super(ExitFullScreenInitial());

  @override
  Stream<ExitFullScreenState> mapEventToState(
      ExitFullScreenEvent event) async* {
    //
    yield ExitFullScreenLoading();
    if (event is ExitFullScreenEventLoad) {
      yield ExitFullScreenLoaded();
    }
  }
}
