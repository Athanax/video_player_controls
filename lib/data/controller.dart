import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum VideoSource { NETWORK, ASSET }

// ignore: must_be_immutable
class Controller extends Equatable {
  /// Initialize the Video on Startup. This will prep the video for playback.
  final bool autoInitialize;

  /// Play the video as soon as it's displayed
  final bool autoPlay;

  /// List of urls to play
  final List<String> urls;

  /// Defines the video source of the video, the VideoSource in set to VideoSource.NETWORK by default
  final VideoSource videoSource;

  /// This is the index url to be played in the [List<String> urls] , if not specified, the first url plays by default
  final int index;

  /// Start video at a certain position
  final Duration startAt;

  /// Whether or not the video should loop
  final bool isLooping;

  /// The Aspect Ratio of the Video. Important to get the correct size of the
  /// video!
  ///
  /// Will fallback to fitting within the space allowed.
  final double aspectRatio;

  /// The placeholder is displayed underneath the Video before it is initialized
  /// or played.
  final Widget placeholder;

  /// Defines if the player will sleep in fullscreen or not
  final bool allowedScreenSleep;

  /// Defines if the controls should be for live stream video
  final bool isLive;

  /// this is the title of the video
  final String title;

  /// if true, the subtitles button i9s shown
  final bool hasSubtitles;

  /// Defines whether to show controls and progress indicator, it is set to true by default
  final bool showControls;

  /// this is a callback funtion which returns void
  final Function showSubtitles;

  /// The controller for the video you want to play
  VideoPlayerController videoPlayerController;

  int playingIndex;

  Controller({
    this.showControls = true,
    this.videoSource = VideoSource.NETWORK,
    this.urls,
    this.index = 0,
    this.title = '',
    this.hasSubtitles = false,
    this.showSubtitles,
    this.autoInitialize = true,
    this.autoPlay = true,
    this.startAt,
    this.isLooping,
    this.aspectRatio,
    this.placeholder,
    this.allowedScreenSleep = false,
    this.isLive = false,
  }) : assert(
            urls != null, "urls must be provided in the controller instance") {
    _initialize();
  }
  @override
  //
  List<Object> get props => [
        videoPlayerController,
        autoInitialize,
        autoPlay,
        startAt,
        isLooping,
        aspectRatio,
        placeholder,
        allowedScreenSleep,
        isLive,
        title,
        hasSubtitles,
        showSubtitles,
      ];

  Future _initialize() async {
    if (videoSource == VideoSource.NETWORK) {
      videoPlayerController = VideoPlayerController.network(urls[index]);
    } else {
      videoPlayerController = VideoPlayerController.asset(urls[index]);
    }

    playingIndex = index;

    await videoPlayerController.setLooping(isLooping);

    if ((autoInitialize || autoPlay) &&
        !videoPlayerController.value.initialized) {
      await videoPlayerController.initialize();
    }

    if (autoPlay) {
      await videoPlayerController.play();
    }

    if (startAt != null) {
      await videoPlayerController.seekTo(startAt);
    }
  }

  
}
