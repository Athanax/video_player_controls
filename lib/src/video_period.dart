import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/bloc/video_position/video_position_bloc.dart';

class VideoPeriod extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const VideoPeriod({Key key, this.videoPlayerController}) : super(key: key);
  @override
  _VideoPeriodState createState() => _VideoPeriodState();
}

class _VideoPeriodState extends State<VideoPeriod> {
  Duration _time = new Duration();

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoPositionBloc, VideoPositionState>(
      listener: (context, state) {
        //
        if (state is VideoPositionLoaded) {
          setState(() {
            _time = state.duration;
          });
        }
      },
      child: Container(
        child: new Row(
          children: <Widget>[
            new Container(
              child: new Text(
                '${formatDuration(_time)} / ${formatDuration(widget.videoPlayerController.value.duration)}',
                style: new TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration position) {
    final ms = position.inMilliseconds;

    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10 ? '$hours' : hours == 0 ? '00' : '0$hours';

    final minutesString =
        minutes >= 10 ? '$minutes' : minutes == 0 ? '00' : '0$minutes';

    final secondsString =
        seconds >= 10 ? '$seconds' : seconds == 0 ? '00' : '0$seconds';

    final formattedTime =
        '${hoursString == '00' ? '' : hoursString + ':'}$minutesString:$secondsString';

    return formattedTime;
  }
}
