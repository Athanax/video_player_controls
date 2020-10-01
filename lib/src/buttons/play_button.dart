import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/bloc/video_playing/video_playing_bloc.dart';
import 'package:video_player_controls/src/buttons/key_events.dart';

class PlayButton extends StatefulWidget {
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  bool isPlaying = true;
  FocusNode _node;

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_node.hasFocus) {
      //
      BlocProvider.of<ShowcontrolsBloc>(context).add(ShowcontrolsEventStart());
    }
  }

  @override
  void initState() {
    //
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    _node = FocusNode(onKey: (node, event) {
      //
      BlocProvider.of<ShowcontrolsBloc>(context).add(ShowcontrolsEventStart());
      handleKeyEvent(node, event, context);

      return false;
    });
    _node.addListener(_onFocusChange);
    // super.initState();
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
            child: new IconButton(
              autofocus: true,
              focusNode: _node,
              color:
                  _node.hasFocus ? Theme.of(context).accentColor : Colors.white,
              focusColor: Colors.transparent,
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
