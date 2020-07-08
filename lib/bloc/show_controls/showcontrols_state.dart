part of 'showcontrols_bloc.dart';

abstract class ShowcontrolsState extends Equatable {
  const ShowcontrolsState();
}

class ShowcontrolsInitial extends ShowcontrolsState {
  const ShowcontrolsInitial();
  @override
  List<Object> get props => [];
}

class ShowcontrolsLoading extends ShowcontrolsState {
  const ShowcontrolsLoading();
  @override
  List<Object> get props => [];
}

class ShowcontrolsRestarted extends ShowcontrolsState {
  const ShowcontrolsRestarted();
  @override
  List<Object> get props => [];
}

class ShowcontrolsStarted extends ShowcontrolsState {
  const ShowcontrolsStarted();
  @override
  List<Object> get props => [];
}
