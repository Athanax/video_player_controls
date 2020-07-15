import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/fast_foward/fast_foward_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';

class FastFowardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
      autofocus: true,
      focusColor: Colors.redAccent,
      color: Colors.white,
      iconSize: 30,
      icon: new Icon(Icons.fast_forward),
      onPressed: () {
        BlocProvider.of<ShowcontrolsBloc>(context)
            .add(ShowcontrolsEventStart());
        BlocProvider.of<FastFowardBloc>(context).add(FastFowardEventLoad());
      },
    );
  }
}
