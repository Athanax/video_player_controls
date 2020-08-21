import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fast_rewind_event.dart';
part 'fast_rewind_state.dart';

class FastRewindBloc extends Bloc<FastRewindEvent, FastRewindState> {
  FastRewindBloc() : super(FastRewindInitial());

  @override
  Stream<FastRewindState> mapEventToState(FastRewindEvent event) async* {
    //
    yield FastRewindLoading();
    if (event is FastRewindEventLoad) {
      yield FastRewindLoaded();
    }
  }
}
