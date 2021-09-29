/// Add [microsecond] into String method.
extension DateMicrosecondExt on DateTime {
  /// When [microsecond] is 0, add [microsecond]
  /// on the result`toIso8601String()` method.
  String toStringWithMicrosecond() {
    if (microsecond == 0) {
      final iso = toIso8601String();
      return '${iso.substring(0, iso.length - 1)}000Z';
    }

    return toIso8601String();
  }
}
