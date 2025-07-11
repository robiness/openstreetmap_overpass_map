/// Exception thrown when check-in operations fail
class CheckInException implements Exception {
  final String message;
  final CheckInErrorType type;

  const CheckInException(this.message, this.type);

  @override
  String toString() => 'CheckInException: $message';
}

/// Types of check-in errors
enum CheckInErrorType {
  tooFarAway,
  locationUnavailable,
  permissionDenied,
  unknown,
}