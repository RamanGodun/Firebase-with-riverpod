import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🧩 [OverlayStatusCubit] — Manages current overlay visibility state.
/// ✅ Used to propagate `isOverlayActive` from [OverlayDispatcher] to UI logic (e.g., disabling buttons).
//----------------------------------------------------------------------------------------------------
final overlayStatusProvider =
    StateNotifierProvider<OverlayStatusNotifier, bool>((ref) {
      return OverlayStatusNotifier();
    });

final class OverlayStatusNotifier extends StateNotifier<bool> {
  OverlayStatusNotifier() : super(false);
  void update(bool isActive) => state = isActive;
}

///

/// 🧠 [OverlayStatusX] — Extension for accessing overlay activity status from [BuildContext].
/// ⚠️ Note: For read-only checks only. For reactive usage, prefer listening to [OverlayStatusCubit] via BlocBuilder.
//----------------------------------------------------------------------------------------------------
extension OverlayStatusX on WidgetRef {
  bool get overlayStatus => watch(overlayStatusProvider);
}

/*
! call :
final isOverlayVisible = ref.watch(overlayStatusProvider);

 */
