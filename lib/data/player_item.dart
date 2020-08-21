import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PlayerItem extends Equatable {
  /// Title of the video
  final String title;

  /// URL of the video
  final String url;

  /// Subtitles url of the video, the link should locate a vtt subtitle file
  final String subtitleUrl;

  /// Will fallback to fitting within the space allowed.
  final double aspectRatio;

  /// Any other information the you can use to identify the playing video
  final customInfo;

  /// Returns the position of the playing item
  Duration position;

  /// Duration returns th duration of the playing item
  Duration duration;

  /// Start video at a certain position
  final Duration startAt;

  PlayerItem(
      {this.title = '',
      this.url,
      this.startAt,
      this.aspectRatio,
      this.subtitleUrl,
      this.customInfo})
      : assert(url != null, 'url must be provided in the PlayerItem class');

  @override
  //
  List<Object> get props => [title, url, subtitleUrl, customInfo];
}
