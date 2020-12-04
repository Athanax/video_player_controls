import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'showcontrols_event.dart';
part 'showcontrols_state.dart';

class ShowcontrolsBloc extends Bloc<ShowcontrolsEvent, ShowcontrolsState> {
  ShowcontrolsBloc() : super(ShowcontrolsInitial());

  @override
  Stream<ShowcontrolsState> mapEventToState(ShowcontrolsEvent event) async* {
    //
    yield ShowcontrolsLoading();
    if (event is ShowcontrolsEventStart) yield ShowcontrolsStarted();

    //  else if (event is ShowcontrolsEventRestart) {
    //   yield ShowcontrolsRestarted();
    // }
  }
}
