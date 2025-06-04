import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../failures_for_domain_and_presentation/failure_ui_model.dart';
import '../utils/consumable.dart';

/// 📦 Extension to wrap any object in a [Consumable]
extension ConsumableX<T> on T {
  Consumable<T> asConsumable() => Consumable(this);
}

///
extension FailureUIContextX on BuildContext {
  void consumeErrorUI(
    WidgetRef ref,
    Consumable<FailureUIModel>? Function() get,
  ) {
    final model = get()?.consume();
    if (model != null) showError(model);
  }
}
