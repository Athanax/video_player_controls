import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:video_player_controls/bloc/video_duration/video_duration_bloc.dart';
import 'package:video_player_controls/bloc/video_position/video_position_bloc.dart';

class TvProgress extends StatefulWidget {
  @override
  _TvProgressState createState() => _TvProgressState();
}

class _TvProgressState extends State<TvProgress> {
  double position = 0;
  double _duration = 1;
  FocusNode focusNode;

  @override
  void initState() {
    //
    focusNode =
        FocusNode(canRequestFocus: false, descendantsAreFocusable: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoPositionBloc, VideoPositionState>(
      listener: (context, state) {
        if (state is VideoPositionLoaded)
          setState(() {
            position = state.duration.toDouble();
          });
      },
      child: BlocListener<VideoDurationBloc, VideoDurationState>(
        listener: (context, state) {
          if (state is VideoDurationLoaded)
            setState(() {
              _duration = state.duration.toDouble();
            });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: StepProgressIndicator(
            totalSteps: _duration.toInt(),
            currentStep: position.toInt(),
            size: 5,
            padding: 0,
            selectedColor: Theme.of(context).accentColor,
            unselectedColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
