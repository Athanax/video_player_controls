import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/previous_video/previous_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/src/buttons/cover.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({this.isRtl = false});
  final bool isRtl;
  @override
  Widget build(BuildContext context) {
    return Cover(
      icon: isRtl ? Icons.skip_next_outlined : Icons.skip_previous_outlined,
      iconSize: 40,
      onTap: () {
        BlocProvider.of<ShowcontrolsBloc>(context)
            .add(ShowcontrolsEventStart());
        BlocProvider.of<PreviousVideoBloc>(context)
            .add(PreviousVideoEventLoad());
      },
    );
  }
}
