import 'dart:async';
import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../shared_presentation/constants/_app_constants.dart';
import '../../localization/code_base_for_both_options/text_widget.dart';

part 'overlay_widget.dart';

/// 🌟 [OverlayNotificationService] — macOS-style overlay (snackbar replacement)
/// 🧼 Shows a floating, styled, animated banner for temporary notifications
//----------------------------------------------------------------//

enum OverlayPosition { top, center, bottom }

class OverlayNotificationService {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  /// 📌 Shows a transient overlay with [message] and [icon]
  static void showOverlay(
    BuildContext context, {
    required String message,
    required IconData icon,
    OverlayPosition position = OverlayPosition.center,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (_isShowing) return;
    _isShowing = true;

    _removeOverlay();

    final overlay = Overlay.of(context, rootOverlay: true);
    _overlayEntry = OverlayEntry(
      builder:
          (_) => _AnimatedOverlayWidget(
            message: message,
            icon: icon,
            position: position,
          ),
    );

    overlay.insert(_overlayEntry!);

    Future.delayed(duration, () {
      _removeOverlay();
      _isShowing = false;
    });
  }

  /// 🧹 Removes any currently visible overlay
  static void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// 🎯 Convenience API methods
  static void success(BuildContext context, String message) =>
      showOverlay(context, message: message, icon: Icons.check_circle);

  static void error(BuildContext context, String message) =>
      showOverlay(context, message: message, icon: Icons.error);

  static void info(BuildContext context, String message) =>
      showOverlay(context, message: message, icon: Icons.info);
}
