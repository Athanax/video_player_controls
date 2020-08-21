part of 'player_item_bloc.dart';

abstract class PlayerItemEvent extends Equatable {
  const PlayerItemEvent();
}

class PlayerItemEventLoad extends PlayerItemEvent {
  final PlayerItem playerItem;

  PlayerItemEventLoad(this.playerItem);
  @override
  //
  List<Object> get props => [playerItem];
}
