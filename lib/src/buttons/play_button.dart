import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/bloc/video_playing/video_playing_bloc.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    Key key,
  }) : super(key: key);
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  bool isPlaying = true;
  @override
  void initState() {
    //
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          child: BlocListener<VideoPlayingBloc, VideoPlayingState>(
            listener: (context, state) {
              if (state is VideoPlayingLoaded) {
                if (state.isPlaying == true) {
                  animationController.reverse();
                  setState(() {
                    isPlaying = true;
                  });
                } else {
                  animationController.forward();
                  setState(() {
                    isPlaying = false;
                  });
                }
              }
            },
            // child: BlocListener<PlayVideoBloc, PlayVideoState>(
            //   listener: (context, state) {
            //     if (state is PlayVideoLoaded) {
            //       animationController.reverse();
            //       setState(() {
            //         isPlaying = true;
            //       });
            //     }
            //   },
            //   child: BlocListener<PauseVideoBloc, PauseVideoState>(
            //     listener: (context, state) {
            //       if (state is PauseVideoLoaded) {
            //         animationController.forward();
            //         setState(() {
            //           isPlaying = false;
            //         });
            //       }
            //     },
            child: new IconButton(
              color: Colors.white,
              iconSize: 30,
              icon: new AnimatedIcon(
                  icon: AnimatedIcons.pause_play,
                  progress: animationController),
              onPressed: () {
                BlocProvider.of<ShowcontrolsBloc>(this.context)
                    .add(ShowcontrolsEventStart());
                if (isPlaying == true) {
                  BlocProvider.of<PauseVideoBloc>(context)
                      .add(PauseVideoEventLoad());
                } else {
                  BlocProvider.of<PlayVideoBloc>(context)
                      .add(PlayVideoEventLoad());
                }
              },
            ),
          ),
          // ),
          // ),
        ),
      ],
    );
  }
}
