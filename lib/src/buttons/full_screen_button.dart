import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/enter_full_screen/enter_full_screen_bloc.dart';
import 'package:video_player_controls/bloc/exit_full_screen/exit_full_screen_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';

class FullScreenButton extends StatefulWidget {
  @override
  _FullScreenButtonState createState() => _FullScreenButtonState();
}

class _FullScreenButtonState extends State<FullScreenButton> {
  bool isFullScreen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MultiBlocListener(
        listeners: [
          BlocListener<EnterFullScreenBloc, EnterFullScreenState>(
              listener: (context, state) {
            if (state is EnterFullScreenLoaded) {
              //
              setState(() {
                isFullScreen = true;
              });
            }
          }),
          BlocListener<ExitFullScreenBloc, ExitFullScreenState>(
              listener: (context, state) {
            if (state is ExitFullScreenLoaded) {
              //
              setState(() {
                isFullScreen = false;
              });
            }
          }),
        ],
        child: isFullScreen == true
            ? new IconButton(
                color: Colors.white,
                iconSize: 30,
                icon: new Icon(Icons.fullscreen_exit),
                onPressed: () {
                  BlocProvider.of<ShowcontrolsBloc>(context)
                      .add(ShowcontrolsEventStart());
                  BlocProvider.of<ExitFullScreenBloc>(context)
                      .add(ExitFullScreenEventLoad());
                },
              )
            : new IconButton(
                color: Colors.white,
                iconSize: 30,
                icon: new Icon(Icons.fullscreen),
                onPressed: () {
                  BlocProvider.of<ShowcontrolsBloc>(context)
                      .add(ShowcontrolsEventStart());
                  BlocProvider.of<EnterFullScreenBloc>(context)
                      .add(EnterFullScreenEventLoad());
                },
              ),
      ),
    );
  }
}
