import 'package:flutter/material.dart';

import '../../presentation/widgets/text_widget.dart';

/*
? maybe should separate to different utils and name them accordingly? */

/// 📦 [Helpers] — UI & navigation utility methods.
/// Includes shortcuts for:
///   • Navigation (goNamed, pushNamed)
///   • Theme & color accessors
///   • Common UI actions
class Helpers {
  // ===========================
  // 🧩 Controllers helpers
  // ===========================
  static List<TextEditingController> createControllers(int count) {
    return List.generate(count, (index) => TextEditingController());
  }

  /// Disposes all controllers in the list
  static void disposeControllers(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }

  /// ===========================
  /// 🧩 FOR SNACKBAR
  // ===========================

  /// Shows a snackbar message
  static void showSnackbar(
    ScaffoldMessengerState scaffoldMessenger,
    String message,
  ) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: TextWidget(message, TextType.bodyMedium)),
    );
  }

  ///
}
