import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../failures_for_domain_and_presentation/failure_for_domain.dart';

/// 🧩 [AsyncValueX] — розширення для витягування Failure із AsyncError
extension AsyncValueX<T> on AsyncValue<T> {
  /// ❌ Повертає Failure, якщо стан — AsyncError з Failure
  Failure? get asFailure {
    final error = this;
    if (error is AsyncError && error.error is Failure) {
      return error.error as Failure;
    }
    return null;
  }
}
