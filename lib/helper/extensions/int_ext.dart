extension FilesCountExt on int {
  String getFileCountText() {
    if (this > 1) {
      return '$this files';
    } else if (this == 1) {
      return '$this file';
    } else {
      return 'No file Available';
    }
  }
}

extension WordCountExt on int {
  String getWordCountText() {
    if (this > 1) {
      return '$this words';
    } else if (this == 1) {
      return '$this word';
    } else {
      return '0 word';
    }
  }
}
