import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player_controls/data/player_item.dart';

enum VideoSource { NETWORK, ASSET }

// ignore: must_be_immutable
class Controller extends Equatable {
  /// Initialize the Video on Startup. This will prep the video for playback.
  final bool autoInitialize;

  /// Play the video as soon as it's displayed
  final bool autoPlay;

  /// List of urls to play
  final List<PlayerItem> items;

  /// Defines the video source of the video, the VideoSource in set to VideoSource.NETWORK by default
  final VideoSource videoSource;

  /// This is the index url to be played in the [List<String> urls] , if not specified, the first url plays by default
  int index;

  /// Start video at a certain position
  final Duration startAt;

  /// Whether or not the video should loop
  final bool isLooping;

  /// Will fallback to fitting within the space allowed.
  final double aspectRatio;

  /// The placeholder is displayed underneath the Video before it is initialized
  /// or played.
  final Widget placeholder;

  /// Defines if the player will sleep in fullscreen or not
  final bool allowedScreenSleep;

  /// Defines if the controls should be for live stream video
  final bool isLive;

  /// Displays seek buttons if true alse hides them,
  /// The buttons will show by default if not specified
  final bool showSeekButtons;

  /// Displays skip next and previous buttons if true alse hides them,
  /// The buttons will show by default if not specified
  final bool showSkipButtons;

  /// if true, the subtitles button i9s shown
  final bool hasSubtitles;

  /// Defines whether to show controls and progress indicator, it is set to true by default
  final bool showControls;

  /// Returns with true if the playing else false
  final ValueChanged<bool> isPlaying;

  /// Called with error if an error occurs
  final ValueChanged onError;

  /// returns the PlayerItem that is currently playing
  final ValueChanged<PlayerItem> playerItem;

  // int playingIndex;

  Controller({
    this.showControls = true,
    this.videoSource = VideoSource.NETWORK,
    this.items,
    this.showSeekButtons = true,
    this.showSkipButtons = true,
    this.isPlaying,
    this.onError,
    this.playerItem,
    this.index = 0,
    this.hasSubtitles = false,
    this.autoInitialize = true,
    this.autoPlay = true,
    this.startAt,
    this.isLooping,
    this.aspectRatio,
    this.placeholder,
    this.allowedScreenSleep = false,
    this.isLive = false,
  }) : assert(
            items != null, "urls must be provided in the controller instance");
  @override
  //
  List<Object> get props => [
        autoInitialize,
        autoPlay,
        startAt,
        isLooping,
        aspectRatio,
        placeholder,
        allowedScreenSleep,
        isLive,
        hasSubtitles,
        index
      ];
}
