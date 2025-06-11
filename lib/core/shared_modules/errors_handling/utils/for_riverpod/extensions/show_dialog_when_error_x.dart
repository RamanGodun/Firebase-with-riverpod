import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/for_riverpod/failure_async_value_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🧩 [ContextAsyncValueX] — extension for showing [Failure]s from [AsyncValue]
extension RefFailureListenerX on WidgetRef {
  void listenFailure<T>(
    ProviderListenable<AsyncValue<T>> provider,
    BuildContext context,
  ) {
    listen<AsyncValue<T>>(provider, (prev, next) {
      final failure = next.asFailure;
      if (failure != null) context.showError(failure.toUIModel());
    });
  }
}
