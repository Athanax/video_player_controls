import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'load_player_event.dart';
part 'load_player_state.dart';

class LoadPlayerBloc extends Bloc<LoadPlayerEvent, LoadPlayerState> {
  LoadPlayerBloc() : super(LoadPlayerInitial());

  @override
  Stream<LoadPlayerState> mapEventToState(LoadPlayerEvent event) async* {
    //
    if (event is LoadPlayerEventLoad) {
      yield LoadPlayerLoaded();
    }
  }
}
