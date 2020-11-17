import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player_controls/data/player_item.dart';
import 'package:video_player_controls/utils/contract.dart';

enum VideoSource { NETWORK, ASSET }

// ignore: must_be_immutable
class Controller extends Equatable {
  /// Initialize the Video on Startup. This will prep the video for playback.
  final bool autoInitialize;

  /// Play the video as soon as it's displayed
  final bool autoPlay;

  /// Play the video as soon as it's displayed
  final bool showBackButton;

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

  /// The placeholder is displayed underneath the Video before it is initialized
  /// or played.
  final Widget placeholder;

  /// Defines if the player will sleep in fullscreen or not
  /// If false, the screen doesn't sleep until the player disposed
  final bool allowedScreenSleep;

  /// Defines if the controls should be for live stream video
  final bool isLive;

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

  /// This is a callback function called when the last video is played
  final ValueChanged<bool> videosCompleted;

  /// this is a custom loading indicator widget
  final Widget loader;

  ///
  final Widget Function(BuildContext context, String message) errorBuilder;

  Contract view;

  Controller({
    this.showControls = true,
    this.videoSource = VideoSource.NETWORK,
    this.items,
    this.fullScreenByDefault = false,
    this.allowFullScreen = true,
    this.showSkipButtons = true,
    this.showBackButton = true,
    this.isPlaying,
    this.videosCompleted,
    this.errorBuilder,
    this.playerItem,
    this.loader,
    this.index = 0,
    this.hasSubtitles = false,
    this.autoInitialize = true,
    this.autoPlay = true,
    this.isLooping = false,
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
        placeholder,
        allowedScreenSleep,
        isLive,
        hasSubtitles,
        index,
        errorBuilder,
      ];

  /// Pause a video
  void pause() {
    view.pause();
  }

  /// Play a video
  void play() {
    view.play();
  }

  /// Fast foward a video
  void foward(int seconds) {
    view.foward(seconds);
  }

  /// Fast rewird a video
  void rewind(int seconds) {
    view.rewind(seconds);
  }

  /// Play the next video in the list
  void next() {
    view.next();
  }

  /// Play the previous video in the list
  void previous() {
    view.previous();
  }

  /// skip to a specific video in the list
  void setIndex(int index) {
    view.setIndex(index);
  }
}
