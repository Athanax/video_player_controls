abstract class Contract {
  /// Pause a video
  void pause();

  /// Play a video
  void play();

  /// Play the next video
  void next();

  /// Play the previous video
  void previous();

  /// Fast foward a video
  void foward();

  /// fast rewind a video
  void rewind();

  /// skip to a specific video in the list
  void setIndex(int index);
}
