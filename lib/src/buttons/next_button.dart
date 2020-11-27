import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/next_video/next_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/src/buttons/cover.dart';

class NextButton extends StatelessWidget {
  const NextButton({this.isRtl = false});
  final bool isRtl;
  @override
  Widget build(BuildContext context) {
    return new Cover(
      icon: isRtl ? Icons.skip_previous_outlined : Icons.skip_next_outlined,
      iconSize: 40,
      onTap: () {
        BlocProvider.of<ShowcontrolsBloc>(context)
            .add(ShowcontrolsEventStart());
        BlocProvider.of<NextVideoBloc>(context).add(NextVideoEventLoad());
      },
    );
  }
}
