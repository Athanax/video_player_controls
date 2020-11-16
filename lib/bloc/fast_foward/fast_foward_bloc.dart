import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fast_foward_event.dart';
part 'fast_foward_state.dart';

class FastFowardBloc extends Bloc<FastFowardEvent, FastFowardState> {
  FastFowardBloc() : super(FastFowardInitial());

  @override
  Stream<FastFowardState> mapEventToState(FastFowardEvent event) async* {
    //
    yield FastFowardLoading();
    if (event is FastFowardEventLoad) {
      yield FastFowardLoaded(event.seconds);
    }
  }
}
