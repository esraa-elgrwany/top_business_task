import 'dart:async';
import 'dart:ui';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  /// Runs the provided [action] after the specified [delay] duration has passed.
  /// If this method is called again before the timer finishes, the previous
  /// timer is cancelled and restarted.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}