import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player_controls/data/progress_colors.dart';
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

  /// This is the index url to be played in the [items] , if not specified, the first url plays by default
  int index;

  /// If true, the video plays in fullscreen mode and either landscape mode both left and right
  /// this property if false by default
  final bool fullScreenByDefault;

  /// This property is true by default.
  /// If true, a toggle enter-fullscreen exit fullscreen button is available on the screen.
  /// the button won't display if [fullScreenByDefault] is true. You know the reason.
  final bool allowFullScreen;

  /// Whether or not the video should loop
  final bool isLooping;

  /// Will fallback to fitting within the space allowed.
  final double aspectRatio;

  /// The placeholder is displayed underneath the Video before it is initialized
  /// or played.
  final Widget placeholder;

  /// Defines if the player will sleep in fullscreen or not
  /// If false, the screen doesn't sleep until the player disposed
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

  /// Returns the PlayerItem that is currently playing
  final ValueChanged<PlayerItem> playerItem;

  /// Returns a Map with true the error message if an error occurs
  final ValueChanged<Map<String, dynamic>> onError;
  // int playingIndex;

  final Widget loader;

  final ProgressColors progressColors;

  Controller({
    this.showControls = true,
    this.videoSource = VideoSource.NETWORK,
    this.items,
    this.fullScreenByDefault = false,
    this.allowFullScreen = true,
    this.showSeekButtons = true,
    this.showSkipButtons = true,
    this.isPlaying,
    this.onError,
    this.playerItem,
    this.progressColors,
    this.loader,
    this.index = 0,
    this.hasSubtitles = false,
    this.autoInitialize = true,
    this.autoPlay = true,
    this.isLooping = false,
    this.aspectRatio,
    this.placeholder,
    this.allowedScreenSleep = true,
    this.isLive = false,
  }) : assert(
            items != null, "urls must be provided in the controller instance");
  @override
  //
  List<Object> get props => [
        autoInitialize,
        autoPlay,
        isLooping,
        aspectRatio,
        placeholder,
        allowedScreenSleep,
        isLive,
        hasSubtitles,
        index,
        progressColors
      ];
}
