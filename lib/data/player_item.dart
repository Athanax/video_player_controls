import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PlayerItem extends Equatable {
  /// Title of the video
  final String title;

  /// URL of the video
  final String url;

  /// Subtitles url of the video
  final String subtitleUrl;

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
      this.subtitleUrl,
      this.customInfo})
      : assert(url != null, 'url must be provided in the PlayerItem class');

  @override
  //
  List<Object> get props => [title, url, subtitleUrl, customInfo];
}
