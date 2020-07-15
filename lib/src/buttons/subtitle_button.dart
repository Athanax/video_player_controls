import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/data/controller.dart';

class SubtitleButton extends StatelessWidget {
  final Controller controller;

  const SubtitleButton({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: new IconButton(
          autofocus: true,
          focusColor: Colors.redAccent,
          color: Colors.white,
          iconSize: 30,
          icon: new Icon(Icons.closed_caption),
          onPressed: () {
            //
            BlocProvider.of<ShowcontrolsBloc>(context)
                .add(ShowcontrolsEventStart());
          }),
    );
  }
}
