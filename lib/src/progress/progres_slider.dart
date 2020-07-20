import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/seek_video/seek_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/bloc/video_duration/video_duration_bloc.dart';
import 'package:video_player_controls/bloc/video_position/video_position_bloc.dart';
import 'package:video_player_controls/data/progress_colors.dart';

class ProgressSlider extends StatefulWidget {
  final ProgressColors progressColors;
  const ProgressSlider({
    Key key,
    this.progressColors,
  }) : super(key: key);

  @override
  _ProgressSliderState createState() => _ProgressSliderState();
}

class _ProgressSliderState extends State<ProgressSlider> {
  double position = 0;
  double _duration = 1;
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
            print(state.duration);
          }
        },
        child: Slider(
          activeColor: widget.progressColors != null
              ? widget.progressColors.playedColor
              : Theme.of(context).buttonColor,
          inactiveColor: Colors.white38,
          value: position,
          onChanged: (value) {
            //
            BlocProvider.of<ShowcontrolsBloc>(context)
                .add(ShowcontrolsEventStart());
            BlocProvider.of<SeekVideoBloc>(context)
                .add(SeekVideoEventLoad(new Duration(seconds: value.toInt())));
          },
          onChangeEnd: (duration) {
            // set the video duration to the time
            //
            BlocProvider.of<PlayVideoBloc>(context).add(PlayVideoEventLoad());
          },
          onChangeStart: (duration) {
            // pause the video
            //
            BlocProvider.of<PauseVideoBloc>(context).add(PauseVideoEventLoad());
          },
          min: 0,
          // max: _duration,
          max: _duration,
        ),
      ),
    );
  }
}
