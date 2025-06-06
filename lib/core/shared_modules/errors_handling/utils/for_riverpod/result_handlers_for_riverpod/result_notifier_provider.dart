import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'result_notifier.dart';

/// 🧩 [resultNotifierProvider<T>] — family provider without codegen
AsyncNotifierProvider<ResultNotifier<T>, T?> asyncResultNotifierProvider<T>() {
  return AsyncNotifierProvider<ResultNotifier<T>, T?>(
    () => ResultNotifier<T>(),
  );
}
