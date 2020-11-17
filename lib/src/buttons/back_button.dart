import 'package:flutter/material.dart';
import 'package:video_player_controls/src/buttons/cover.dart';

class TopBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Cover(
      icon: Icons.arrow_back_outlined,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
