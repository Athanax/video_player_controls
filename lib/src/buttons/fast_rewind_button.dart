import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/fast_rewind/fast_rewind_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/src/buttons/cover.dart';

class FastRewindButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Cover(
      icon: Icons.fast_rewind,
      onTap: () {
        BlocProvider.of<ShowcontrolsBloc>(context)
            .add(ShowcontrolsEventStart());
        BlocProvider.of<FastRewindBloc>(context).add(FastRewindEventLoad());
      },
    );
  }
}
