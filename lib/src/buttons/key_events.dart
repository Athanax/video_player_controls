import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/fast_foward/fast_foward_bloc.dart';
import 'package:video_player_controls/bloc/fast_rewind/fast_rewind_bloc.dart';
import 'package:video_player_controls/bloc/next_video/next_video_bloc.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/previous_video/previous_video_bloc.dart';

bool handleKeyEvent(FocusNode node, RawKeyEvent event, context) {
  if (event.logicalKey == LogicalKeyboardKey.mediaRewind) {
    // Rewind
    BlocProvider.of<FastRewindBloc>(context).add(FastRewindEventLoad(10));
  } else if (event.logicalKey == LogicalKeyboardKey.mediaFastForward) {
    // Fast foward
    BlocProvider.of<FastFowardBloc>(context).add(FastFowardEventLoad(20));
  } else if (event.logicalKey == LogicalKeyboardKey.mediaPlay) {
    // Play
    BlocProvider.of<PlayVideoBloc>(context).add(PlayVideoEventLoad());
  } else if (event.logicalKey == LogicalKeyboardKey.pause ||
      event.logicalKey == LogicalKeyboardKey.mediaPlayPause) {
    // Pause
    BlocProvider.of<PauseVideoBloc>(context).add(PauseVideoEventLoad());
  } else if (event.logicalKey == LogicalKeyboardKey.mediaTrackNext) {
    // Pause
    BlocProvider.of<NextVideoBloc>(context).add(NextVideoEventLoad());
  } else if (event.logicalKey == LogicalKeyboardKey.mediaTrackPrevious) {
    // Pause
    BlocProvider.of<PreviousVideoBloc>(context).add(PreviousVideoEventLoad());
  } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
    // Pause
    BlocProvider.of<FastRewindBloc>(context).add(FastRewindEventLoad(10));
    return true;
  } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
    // Pause
    BlocProvider.of<FastFowardBloc>(context).add(FastFowardEventLoad(20));
    return true;
  }

  return false;
}

Future<bool> handlArrowKeys(FocusNode node, RawKeyEvent event, context) async {
  if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
    // Rewind
    BlocProvider.of<FastRewindBloc>(context).add(FastRewindEventLoad(10));
  } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
    // Fast foward
    BlocProvider.of<FastFowardBloc>(context).add(FastFowardEventLoad(20));
  }

  return false;
}
