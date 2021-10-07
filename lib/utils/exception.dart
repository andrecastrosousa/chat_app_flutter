
import 'request_messages.dart';

class CacheException implements Exception {
  CacheException({this.code, this.message, this.details});

  /// An error code.
  final int? code;

  /// A human-readable error message, possibly null.
  final String? message;

  /// Error details, possibly null.
  final dynamic details;
}

class ServerException implements Exception {
  ServerException({this.code, this.message, this.details});

  /// An error code.
  final int? code;

  /// A human-readable error message, possibly null.
  final String? message;

  /// Error details, possibly null.
  final dynamic details;
}

class NetworkException implements Exception {
  NetworkException({this.code, this.message, this.details});

  /// An error code.
  final int? code;

  /// A human-readable error message, possibly null.
  final String? message;

  /// Error details, possibly null.
  final dynamic details;
}
