import 'package:meta/meta.dart';
import 'package:stack_trace/stack_trace.dart' show Trace;

Logger log = Logger(
  loggable: true,
  level: LogLevel.debug,
);

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class Logger {
  Logger._(LogLevel level) {
    _level = level;
  }

  factory Logger({@required bool loggable, @required LogLevel level}) {
    if (_instance == null) {
      _instance = Logger._(level);
    } else {
      _level = level;
    }

    return loggable ? _instance : null;
  }

  static Logger _instance;
  static LogLevel _level;

  void d(String msg) => (_level.index <= LogLevel.debug.index)
      ? _trace('debug', msg) : null;

  void i(String msg) => (_level.index <= LogLevel.info.index)
      ? _trace('info', msg) : null;

  void w(String msg) => (_level.index <= LogLevel.warning.index)
      ? _trace('warning', msg) : null;

  void e(String msg) => (_level.index <= LogLevel.error.index)
      ? _trace('error', msg) : null;

  void _trace(String level, String msg) {
    final frames = Trace.current(2).frames;
    final frame = (frames?.isNotEmpty ?? false) ? frames.first : null;
    print("[$level] $frame: $msg");
  }
}
