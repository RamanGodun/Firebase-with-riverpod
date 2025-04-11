import 'dart:async';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../constants/app_constants.dart';
import '../../../presentation/widgets/text_widget.dart';

part 'overlay_widget.dart';

/// 🌟 [OverlayNotificationService] — macOS-style overlay banner (snackbar alternative)
class OverlayNotificationService {
  static OverlayEntry? _overlayEntry;

  /// 📌 Displays a custom animated overlay (toast-style).
  static void showOverlay(
    BuildContext context, {
    required String message,
    required IconData icon,
  }) {
    _removeOverlay();

    final overlay = Overlay.of(context, rootOverlay: true);

    _overlayEntry = OverlayEntry(
      builder: (_) => _AnimatedOverlayWidget(message: message, icon: icon),
    );

    overlay.insert(_overlayEntry!);
    Future.delayed(const Duration(seconds: 2), _removeOverlay);
  }

  /// 🛑 Closes and removes the overlay from screen.
  static void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
