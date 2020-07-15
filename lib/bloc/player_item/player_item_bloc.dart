import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player_controls/video_player_controls.dart';

part 'player_item_event.dart';
part 'player_item_state.dart';

class PlayerItemBloc extends Bloc<PlayerItemEvent, PlayerItemState> {
  PlayerItemBloc() : super(PlayerItemInitial());

  @override
  Stream<PlayerItemState> mapEventToState(PlayerItemEvent event) async* {
    //
    yield PlayerItemLoading();
    if (event is PlayerItemEventLoad) {
      yield PlayerItemLoaded(event.playerItem);
    }
  }
}
