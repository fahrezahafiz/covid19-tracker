import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Result<T> {
  ResultType type;
  String message;
  int statusCode;
  T data;

  Result(this.type, this.message, {this.statusCode, this.data});

  Color get color {
    switch (type) {
      case ResultType.Success:
        return Colors.green;
      case ResultType.Warning:
        return Colors.orange;
      case ResultType.Error:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  IconData get iconData {
    switch (type) {
      case ResultType.Success:
        return Icons.check;
      case ResultType.Warning:
        return Icons.warning;
      case ResultType.Error:
        return Icons.error_outline;
      default:
        return Icons.info_outline;
    }
  }

  Icon get icon {
    switch (type) {
      case ResultType.Success:
        return Icon(iconData, color: color);
      case ResultType.Warning:
        return Icon(iconData, color: color);
      case ResultType.Error:
        return Icon(iconData, color: color);
      default:
        return Icon(Icons.info_outline, color: color);
    }
  }

  Result.success(String message, T data) {
    this
      ..type = ResultType.Success
      ..message = message
      ..data = data;
  }

  Result.fromError(DioError e) {
    this
      ..type = ResultType.Error
      ..statusCode = e.response.statusCode;
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        this.message = 'Connection timed out';
        break;
      case DioErrorType.SEND_TIMEOUT:
        this.message = 'Connection timed out';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        this.message = 'Connection timed out';
        break;
      case DioErrorType.RESPONSE:
        this.message = 'Failed to load';
        this.data = e.response.data;
        break;
      case DioErrorType.CANCEL:
        this.message = 'Request cancelled';
        break;
      case DioErrorType.DEFAULT:
        this.message = 'An error occured';
        break;
    }
  }
}

enum ResultType { Success, Warning, Error }
