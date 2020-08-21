import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/bloc/show_subtitles/show_subtitles_bloc.dart';
import 'package:video_player_controls/src/buttons/cover.dart';

class SubtitleButton extends StatelessWidget {
  const SubtitleButton({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: new Cover(
        icon: Icons.closed_caption,
        onTap: () {
          BlocProvider.of<ShowcontrolsBloc>(context)
              .add(ShowcontrolsEventStart());
          BlocProvider.of<ShowSubtitlesBloc>(context)
              .add(ShowSubtitlesEventLoad());
        },
      ),
    );
  }
}
