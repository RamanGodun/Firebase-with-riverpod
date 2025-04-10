import 'package:flutter/material.dart';
import '../widgets/buttons.dart';
import '../widgets/text_widget.dart';

/// **Firebase Error Page**
/// - Displays an error message when Firebase connection fails.
/// - Provides a retry button for better user experience.

class FirebaseErrorPage extends StatelessWidget {
  const FirebaseErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextWidget('Firebase Connection Error', TextType.error),
              const SizedBox(height: 10.0),
              const TextWidget('Please try again later!', TextType.bodyMedium),
              const SizedBox(height: 20.0),
              CustomButton(
                type: ButtonType.filled,
                onPressed: () => Navigator.pop(context),
                child: const TextWidget('Retry', TextType.button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
