part of 'load_player_bloc.dart';

abstract class LoadPlayerState extends Equatable {
  const LoadPlayerState();
}

class LoadPlayerInitial extends LoadPlayerState {
  const LoadPlayerInitial();
  @override
  List<Object> get props => [];
}

class LoadPlayerLoaded extends LoadPlayerState {
  const LoadPlayerLoaded();
  @override
  List<Object> get props => [];
}
