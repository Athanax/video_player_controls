import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BrightnessSlider extends StatefulWidget {
  @override
  _BrightnessSliderState createState() => _BrightnessSliderState();
}

class _BrightnessSliderState extends State<BrightnessSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.brightness_7_outlined,
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
              Icons.brightness_4_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
