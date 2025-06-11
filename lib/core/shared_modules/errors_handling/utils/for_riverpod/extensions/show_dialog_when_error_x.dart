import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/to_ui_failures_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/for_riverpod/failure_async_value_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🧩 [ContextAsyncValueX] — extension for showing [Failure]s from [AsyncValue] using [BuildContext]
extension ContextAsyncValueX on BuildContext {
  //
  /// ❗️If [value] has a [Failure], shows it via [showError] overlay
  void showDialogWhenErrorState<T>(AsyncValue<T> value) {
    final failure = value.asFailure;
    if (failure != null) {
      showError(failure.toUIModel());
    }
  }
}

///

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
