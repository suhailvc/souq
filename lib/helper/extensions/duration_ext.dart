extension DurationExt on Duration? {
  String convertDurationInTime() {
    if (this == null) {
      return '0 seconds';
    }
    if (this!.inMinutes > 0) {
      if (this!.inMinutes == 1) {
        return '${this!.inMinutes} minute';
      } else {
        return '${this!.inMinutes} minutes';
      }
    } else {
      if (this!.inSeconds == 1) {
        return '${this!.inSeconds} second';
      } else {
        return '${this!.inSeconds} seconds';
      }
    }
  }

  String getHHMMSS() {
    if (this == null) {
      return '00:00';
    }
    if (this!.inHours > 0) {
      return '${this!.inHours.toString().padLeft(2, '0')}:${this!.inMinutes.toString().padLeft(2, '0')}:${this!.inSeconds.toString().padLeft(2, '0')}';
    } else {
      return '${this!.inMinutes.toString().padLeft(2, '0')}:${this!.inSeconds.toString().padLeft(2, '0')}';
    }
  }
}
