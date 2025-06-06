import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'result_notifier_x.dart';

/// 🧩 [resultNotifierProvider<T>] — family provider without codegen
AsyncNotifierProvider<ResultNotifier<T>, T?> resultNotifierProvider<T>() {
  return AsyncNotifierProvider<ResultNotifier<T>, T?>(
    () => ResultNotifier<T>(),
  );
}
