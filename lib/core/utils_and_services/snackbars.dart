import 'package:flutter/material.dart';
import '../../presentation/widgets/text_widget.dart';

/// 📦 [CustomSnackbars] provides some utility methods.
class CustomSnackbars {
  /// ===========================
  /// 🧩 FOR SNACKBAR
  // ===========================

  /// Shows a snackbar message
  static void show(ScaffoldMessengerState scaffoldMessenger, String message) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Center(child: TextWidget(message, TextType.bodyMedium)),
      ),
    );
  }

  ///
}
