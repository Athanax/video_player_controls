part of 'showcontrols_bloc.dart';

abstract class ShowcontrolsEvent extends Equatable {
  const ShowcontrolsEvent();
}

class ShowcontrolsEventStart extends ShowcontrolsEvent {
  const ShowcontrolsEventStart();
  @override
  //
  List<Object> get props => [];
}

// class ShowcontrolsEventRestart extends ShowcontrolsEvent {
//   @override
//   //
//   List<Object> get props => [];
// }
