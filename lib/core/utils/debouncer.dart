import 'dart:async';

/// ⏱️ [Debouncer] — utility for delaying execution after user stops typing/tapping/etc.
/// 🧼 Commonly used for search, validation, and rate-limiting UI actions
//----------------------------------------------------------------//

class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer(this.duration);

  /// 🚀 Runs the [action] after [duration]; resets if called again
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// 🧹 Cancels any scheduled action
  void cancel() => _timer?.cancel();
}
