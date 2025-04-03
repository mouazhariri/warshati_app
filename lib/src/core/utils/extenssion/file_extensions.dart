import 'dart:io';

extension FileExtensions on String {
  bool get isImage {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    return imageExtensions.contains(fileExtension.toLowerCase());
  }

  /// Checks if the file is a video based on its extension.
  bool get isVideo {
    final videoExtensions = ['mp4', 'avi', 'mov', 'mkv', 'flv', 'wmv'];
    return videoExtensions.contains(fileExtension.toLowerCase());
  }

  /// Checks if the file is an audio based on its extension.
  bool get isAudio {
    final audioExtensions = ['mp3', 'wav', 'aac', 'flac', 'ogg', 'wma'];
    return audioExtensions.contains(fileExtension.toLowerCase());
  }

  /// Returns the file extension of the string if it is a file path.
  String get fileExtension {
    return split('.').last;
  }

  /// Returns the file name from the file path.
  String get fileName {
    return split(Platform.pathSeparator).last;
  }
}
