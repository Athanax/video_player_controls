import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class VolumeSlider extends StatefulWidget {
  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.volume_up_outlined,
              color: Colors.white,
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: StepProgressIndicator(
              totalSteps: 10,
              currentStep: 3,
              size: 5,
              padding: 0,
              selectedColor: Theme.of(context).accentColor,
              unselectedColor: Colors.white70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.volume_down_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
