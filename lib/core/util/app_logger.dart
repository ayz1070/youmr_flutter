import 'package:logger/logger.dart';

class AppLogger {
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void d(dynamic message, {String? tag}) =>
      logger.d(_format(message, tag));

  static void i(dynamic message, {String? tag}) =>
      logger.i(_format(message, tag));

  static void w(dynamic message, {String? tag}) =>
      logger.w(_format(message, tag));

  static void e(dynamic message, {String? tag}) =>
      logger.e(_format(message, tag));

  static void v(dynamic message, {String? tag}) =>
      logger.v(_format(message, tag));

  static String _format(dynamic message, String? tag) {
    return tag != null ? '[$tag] $message' : '$message';
  }
}