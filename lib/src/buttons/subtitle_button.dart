import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';

class SubtitleButton extends StatelessWidget {
  const SubtitleButton({
    Key key,
  }) : super(key: key);
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
