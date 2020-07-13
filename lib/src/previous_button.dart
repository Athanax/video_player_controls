import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/previous_video/previous_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';

class PreviousButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
      autofocus: true,
      focusColor: Colors.redAccent,
      color: Colors.white,
      iconSize: 30,
      icon: new Icon(Icons.skip_previous),
      onPressed: () {
        //
        BlocProvider.of<ShowcontrolsBloc>(context)
            .add(ShowcontrolsEventStart());
        BlocProvider.of<PreviousVideoBloc>(context)
            .add(PreviousVideoEventLoad());
      },
    );
  }
}
