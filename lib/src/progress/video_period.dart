import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/video_duration/video_duration_bloc.dart';
import 'package:video_player_controls/bloc/video_position/video_position_bloc.dart';

class VideoPeriod extends StatefulWidget {
  const VideoPeriod({
    Key key,
  }) : super(key: key);
  @override
  _VideoPeriodState createState() => _VideoPeriodState();
}

class _VideoPeriodState extends State<VideoPeriod> {
  int _time = 0;
  int _duration = 1;

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
      child: BlocListener<VideoDurationBloc, VideoDurationState>(
        listener: (context, state) {
          //
          if (state is VideoDurationLoaded) {
            setState(() {
              _duration = state.duration;
            });
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                child: new Text(
                  '${formatDuration(new Duration(seconds: _time))}  ',
                  style: new TextStyle(color: Colors.white),
                ),
              ),
              new Container(
                child: new Text(
                  '${formatDuration(new Duration(seconds: _duration))}',
                  style: new TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
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
