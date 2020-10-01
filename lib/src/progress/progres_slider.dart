import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/seek_video/seek_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/bloc/video_duration/video_duration_bloc.dart';
import 'package:video_player_controls/bloc/video_position/video_position_bloc.dart';
import 'package:video_player_controls/src/buttons/key_events.dart';

class ProgressSlider extends StatefulWidget {
  const ProgressSlider({
    Key key,
  }) : super(key: key);

  @override
  _ProgressSliderState createState() => _ProgressSliderState();
}

class _ProgressSliderState extends State<ProgressSlider>
    with SingleTickerProviderStateMixin {
  double position = 0;
  double _duration = 1;

  @override
  void initState() {
    //
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
        if (state is VideoPositionLoaded) {
          setState(() {
            position = state.duration.toDouble();
          });
        }
      },
      child: BlocListener<VideoDurationBloc, VideoDurationState>(
        listener: (context, state) {
          //
          if (state is VideoDurationLoaded) {
            setState(() {
              _duration = state.duration.toDouble();
            });
          }
        },
        child: Focus(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Slider(
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.white38,
              value: position,
              onChanged: (value) {
                //
                BlocProvider.of<ShowcontrolsBloc>(context)
                    .add(ShowcontrolsEventStart());
                BlocProvider.of<SeekVideoBloc>(context).add(
                    SeekVideoEventLoad(new Duration(seconds: value.toInt())));
              },
              onChangeEnd: (duration) {
                // set the video duration to the time
                //
                BlocProvider.of<PlayVideoBloc>(context)
                    .add(PlayVideoEventLoad());
              },
              onChangeStart: (duration) {
                // pause the video
                //
                BlocProvider.of<PauseVideoBloc>(context)
                    .add(PauseVideoEventLoad());
              },
              min: 0,
              // max: _duration,
              max: _duration,
            ),
          ),
        ),
      ),
    );
  }
}
