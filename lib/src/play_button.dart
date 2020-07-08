import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';

class PlayButton extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const PlayButton({
    Key key,
    this.videoPlayerController,
  }) : super(key: key);
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  bool isPlay = true;
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
            child: new IconButton(
                color: Colors.white,
                iconSize: 30,
                icon: new AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: animationController),
                onPressed: () {
                  BlocProvider.of<ShowcontrolsBloc>(this.context)
                      .add(ShowcontrolsEventStart());
                  if (widget.videoPlayerController.value.isPlaying == true) {
                    animationController.forward();
                    widget.videoPlayerController.pause();
                  } else {
                    animationController.reverse();
                    widget.videoPlayerController.play();
                  }
                })),
      ],
    );
  }
}
