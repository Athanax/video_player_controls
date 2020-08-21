part of 'load_player_bloc.dart';

abstract class LoadPlayerEvent extends Equatable {
  const LoadPlayerEvent();
}

class LoadPlayerEventLoad extends LoadPlayerEvent {
  const LoadPlayerEventLoad();
  @override
  //
  List<Object> get props => [];
}
