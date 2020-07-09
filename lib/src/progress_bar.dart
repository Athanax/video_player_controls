import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/src/play_button.dart';
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
  double selected = 20;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: new Container(
                child: new Row(
                  children: <Widget>[
                    new PlayButton(
                      videoPlayerController: widget.videoPlayerController,
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.white38,
                        value: selected,
                        onChanged: (value) {
                          BlocProvider.of<ShowcontrolsBloc>(this.context)
                              .add(ShowcontrolsEventStart());
                          setState(() {
                            selected = value;
                          });
                        },
                        onChangeEnd: (duration) {
                          // set the video duration to the time
                          print('dragging stopped at' + duration.toString());
                        },
                        onChangeStart: (duration) {
                          // pause the video
                          print('dragging started at' + duration.toString());
                        },
                        min: 0,
                        max: 100,
                      ),
                    ),
                    VideoPeriod()
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
