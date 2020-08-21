part of 'player_item_bloc.dart';

abstract class PlayerItemState extends Equatable {
  const PlayerItemState();
}

class PlayerItemInitial extends PlayerItemState {
  const PlayerItemInitial();
  @override
  List<Object> get props => [];
}

class PlayerItemLoading extends PlayerItemState {
  const PlayerItemLoading();
  @override
  List<Object> get props => [];
}

class PlayerItemLoaded extends PlayerItemState {
  final PlayerItem playerItem;
  const PlayerItemLoaded(this.playerItem);
  @override
  List<Object> get props => [playerItem];
}
