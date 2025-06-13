library;

import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext;

import '../../failures/failure_ui_entity.dart';

/// 🧩 [Consumable] — Wraps a value for one-time consumption.
/// ✅ Prevents repeated UI side-effects (like dialogs/snackbars)
///----------------------------------------------------------------

final class Consumable<T> {
  final T? _value;
  bool _hasBeenConsumed = false;

  Consumable(T value) : _value = value;

  /// Returns value only once (marks as consumed)
  T? consume() {
    if (_hasBeenConsumed) return null;
    _hasBeenConsumed = true;
    return _value;
  }

  /// Returns value without consuming it
  T? peek() => _value;

  /// Resets consumption state (for testing or re-use cases)
  void reset() => _hasBeenConsumed = false;

  /// Indicates if value has already been consumed
  bool get isConsumed => _hasBeenConsumed;

  @override
  String toString() =>
      'Consumable(value: $_value, consumed: $_hasBeenConsumed)';
}

///

/// 📦 Extension to wrap any object in a [Consumable]
extension ConsumableX<T> on T {
  Consumable<T> asConsumable() => Consumable(this);
}

extension FailureUIContextX on BuildContext {
  void consumeAndShowDialog(FailureUIEntity? model) {
    if (model != null) showError(model);
  }

  //
}
