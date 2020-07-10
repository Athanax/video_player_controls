import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';

class SubtitleButton extends StatelessWidget {
  final Function showSubtitles;

  const SubtitleButton({Key key, this.showSubtitles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        autofocus: true,
        focusColor: Colors.redAccent,
        color: Colors.white,
        iconSize: 30,
        icon: new Icon(Icons.closed_caption),
        onPressed: () {
          //
          BlocProvider.of<ShowcontrolsBloc>(context)
              .add(ShowcontrolsEventStart());
          showSubtitles();
        });
  }
}
