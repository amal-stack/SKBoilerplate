import 'dart:async';

class CountdownTimer {
  CountdownTimer({
    required this.duration,
    required this.onTick,
    required this.onComplete,
  }) : _secondsRemaining = duration.inSeconds;

  final Duration duration;
  final void Function(int secondsRemaining) onTick;
  final void Function() onComplete;

  Timer? _timer;

  int _secondsRemaining;

  int get secondsRemaining => _secondsRemaining;

  bool get isRunning => _secondsRemaining > 0 && (_timer?.isActive ?? false);

  bool get isCompleted => _secondsRemaining <= 0;

  String get displayString {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void start() {
    _secondsRemaining = duration.inSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsRemaining--;
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

  void _complete(Timer timer) {
    timer.cancel();
    _secondsRemaining = 0;
    _timer = null;
    onComplete();
  }
  
  void _tick(Timer timer) {
    onTick(_secondsRemaining);
  }
}
