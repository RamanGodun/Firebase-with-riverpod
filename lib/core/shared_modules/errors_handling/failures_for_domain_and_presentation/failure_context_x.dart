import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'failure_ui_model.dart';
import '../utils/consumable.dart';

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
