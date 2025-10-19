import 'package:boilerplate/src/shared/countdown_timer.dart';
import 'package:flutter/widgets.dart';

class CountdownTimerBuilder extends StatefulWidget {
  const CountdownTimerBuilder({
    super.key,
    required this.duration,
    this.interval = const Duration(seconds: 1),
    this.onTick,
    this.onComplete,
    required this.builder,
    this.child,
  }) : timer = null;

  const CountdownTimerBuilder.fromTimer({
    super.key,
    required this.timer,
    this.onTick,
    this.onComplete,
    required this.builder,
    this.child,
  }) : duration = null,
       interval = null;

  final CountdownTimer? timer;
  final Duration? duration;
  final Duration? interval;
  final ValueChanged<CountdownTimer>? onTick;
  final ValueChanged<CountdownTimer>? onComplete;
  final ValueWidgetBuilder<CountdownTimer> builder;

  final Widget? child;

  @override
  State<CountdownTimerBuilder> createState() => _CountdownTimerBuilderState();
}

class _CountdownTimerBuilderState extends State<CountdownTimerBuilder> {
  late CountdownTimer _countdownTimer;

  @override
  void initState() {
    super.initState();
    _initTimer();
    
  }

  void _initTimer() {
    _countdownTimer = widget.timer ?? 
    CountdownTimer(
      duration: widget.duration!,
      interval: widget.interval!,
      onTick: (remaining) {
        setState(() {});
        widget.onTick?.call(_countdownTimer);
      },
      onComplete: () {
        setState(() {});
        if (widget.onComplete != null) {
          widget.onComplete!(_countdownTimer);
        }
      },
    )..start();
  }

  @override
  void didUpdateWidget(covariant CountdownTimerBuilder oldWidget) {
    if (oldWidget.timer != widget.timer) {
      if (oldWidget.timer == null) {
        _countdownTimer.dispose();
      }
      _initTimer();
    }
      
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (widget.timer == null) {
      _countdownTimer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _countdownTimer, widget.child);
}
