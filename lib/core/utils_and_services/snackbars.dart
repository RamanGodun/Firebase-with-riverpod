import 'package:flutter/material.dart';
import '../shared_presentation/widgets/text_widget.dart';

/// 🧩 [CustomSnackbars] — utility for showing consistent snackbars
//----------------------------------------------------------------//

class CustomSnackbars {
  /// 📢 Displays a snackbar with centered [TextWidget]
  static void show(ScaffoldMessengerState messenger, String message) {
    messenger.showSnackBar(
      SnackBar(
        content: Center(child: TextWidget(message, TextType.bodyMedium)),
      ),
    );
  }
}
