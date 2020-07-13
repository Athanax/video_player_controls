import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/seek_video/seek_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/src/fast_foward_button.dart';
import 'package:video_player_controls/src/fast_rewind_button.dart';
import 'package:video_player_controls/src/next_button.dart';
import 'package:video_player_controls/src/play_button.dart';
import 'package:video_player_controls/src/previous_button.dart';
import 'package:video_player_controls/src/video_period.dart';

class ProgressBar extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const ProgressBar({
    Key key,
    this.videoPlayerController,
  }) : super(key: key);
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _position = 0; // changing value; position of the video

  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    //
    _videoPlayerController = widget.videoPlayerController;
    _videoPlayerController.addListener(() => listener());
    super.initState();
  }

  void listener() {
    if (_videoPlayerController != null) {
      setState(() {
        _position =
            _videoPlayerController.value.position.inMilliseconds.toDouble();
      });
    }
  }

  @override
  void dispose() {
    //
    // _videoPlayerController.removeListener(() => listener());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: new Container(
                child: new Column(
                  children: <Widget>[
                    Slider(
                      activeColor: Colors.redAccent,
                      inactiveColor: Colors.white38,
                      value: _position,
                      onChanged: (value) {
                        BlocProvider.of<ShowcontrolsBloc>(this.context)
                            .add(ShowcontrolsEventStart());
                        BlocProvider.of<SeekVideoBloc>(context).add(
                            SeekVideoEventLoad(
                                new Duration(milliseconds: value.toInt())));
                      },
                      onChangeEnd: (duration) {
                        // set the video duration to the time

                        BlocProvider.of<PlayVideoBloc>(context)
                            .add(PlayVideoEventLoad());
                      },
                      onChangeStart: (duration) {
                        // pause the video
                        BlocProvider.of<PauseVideoBloc>(context)
                            .add(PauseVideoEventLoad());
                      },
                      min: 0,
                      // max: _duration,
                      max: widget
                          .videoPlayerController.value.duration.inMilliseconds
                          .toDouble(),
                    ),
                    Row(
                      children: <Widget>[
                        new FastRewindButton(),
                        new PreviousButton(),
                        new PlayButton(),
                        new NextButton(),
                        new FastFowardButton(),
                        new Expanded(child: new Container()),
                        VideoPeriod(
                          videoPlayerController: widget.videoPlayerController,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
