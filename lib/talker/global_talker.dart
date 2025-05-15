import 'package:talker_flutter/talker_flutter.dart';

class GlobalTalker {
  static GlobalTalker? _instance;
  late final Talker _talker;
  late final TalkerLogger _talkerLogger;
  late LogLevel _currentLevel;

  GlobalTalker._internal() {
    _currentLevel = LogLevel.verbose;
    _talkerLogger = TalkerLogger(
      settings: TalkerLoggerSettings(
        enable: true,
        enableColors: true,
        level: _currentLevel,
      ),
    );
    _talker = TalkerFlutter.init(
      logger: _talkerLogger,
      settings: TalkerSettings(enabled: true, useConsoleLogs: true),
    );
  }

  static GlobalTalker get instance {
    _instance ??= GlobalTalker._internal();
    return _instance!;
  }

  Talker get talker => _talker;

  /// 设置日志级别
  void setLogLevel(LogLevel level) {
    _talkerLogger = _talkerLogger.copyWith(filter: LogLevelFilter(level));
    _talker.configure(logger: _talkerLogger);
    _currentLevel = level;
  }

  /// 详细日志
  void verbose(String message, {Object? exception, StackTrace? stackTrace}) {
    _talker.verbose(message, exception, stackTrace);
  }

  /// 调试日志
  void debug(String message, {Object? exception, StackTrace? stackTrace}) {
    _talker.debug(message, exception, stackTrace);
  }

  /// 信息日志
  void info(String message, {Object? exception, StackTrace? stackTrace}) {
    _talker.info(message, exception, stackTrace);
  }

  /// 警告日志
  void warning(String message, {Object? exception, StackTrace? stackTrace}) {
    _talker.warning(message, exception, stackTrace);
  }

  /// 错误日志
  void error(
    String message, {
    dynamic exception,
    StackTrace? stackTrace,
    String? tag,
  }) {
    _talker.error(message, exception, stackTrace);
  }

  /// 严重错误日志
  void critical(String message, {Object? exception, StackTrace? stackTrace}) {
    _talker.critical(message, exception, stackTrace);
  }
}
