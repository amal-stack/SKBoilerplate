import 'dart:async';

class CountdownTimer {
  CountdownTimer({
    required this.duration,
    this.interval = const Duration(seconds: 1),
    required this.onTick,
    required this.onComplete,
  }) : _remaining = duration;

  final Duration duration;
  final Duration interval;
  final void Function(Duration remaining) onTick;
  final void Function() onComplete;

  Timer? _timer;

  Duration _remaining;

  Duration get remaining => _remaining;

  bool get isRunning =>
      _remaining > Duration.zero && (_timer?.isActive ?? false);

  bool get isCompleted => _remaining <= Duration.zero;

  String get displayString {
    var microseconds = _remaining.inMicroseconds;
    final hours = microseconds ~/ Duration.microsecondsPerHour;
    microseconds = microseconds.remainder(Duration.microsecondsPerHour);

    final minutes = microseconds ~/ Duration.microsecondsPerMinute;
    microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

    final seconds = microseconds ~/ Duration.microsecondsPerSecond;
    microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

    final hoursText = hours > 0 ? '${hours.toString().padLeft(2, '0')}:' : '';

    final minutesText = '${minutes.toString().padLeft(2, '0')}:';

    final secondsText = seconds.toString().padLeft(2, '0');

    return '$hoursText$minutesText$secondsText';
  }

  void start() {
    _remaining = duration;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remaining -= interval;
      if (isCompleted) {
        _complete(timer);
        return;
      }
      _tick(timer);
    });
  }

  void reset() {
    stop();
    start();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
  }

  void _tick(Timer timer) {
    onTick(_remaining);
  }

  void _complete(Timer timer) {
    timer.cancel();
    _remaining = Duration.zero;
    _timer = null;
    onComplete();
  }
}

