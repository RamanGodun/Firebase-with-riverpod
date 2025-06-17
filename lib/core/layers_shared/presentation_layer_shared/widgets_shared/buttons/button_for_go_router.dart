import 'package:firebase_with_riverpod/core/modules_shared/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:flutter/cupertino.dart';
import '../../../../modules_shared/localization/widgets/text_widget.dart';
import '../../../../modules_shared/theme/core/constants/_app_constants.dart'
    show AppSpacing;

/// 🌍 [CustomButtonForGoRouter]
/// Styled full-width Cupertino button that triggers navigation or a custom action.

class CustomButtonForGoRouter extends StatelessWidget {
  ///------------------------------------------------

  final String title;
  final String? routeName;
  final Map<String, String>? pathParameters;
  final Map<String, dynamic>? queryParameters;
  final VoidCallback? onPressedCallback;

  const CustomButtonForGoRouter({
    super.key,
    required this.title,
    this.routeName,
    this.pathParameters,
    this.queryParameters,
    this.onPressedCallback,
  });

  ///

  @override
  Widget build(BuildContext context) {
    //
    final scheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xxxs,
      ),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxm),
          borderRadius: BorderRadius.circular(14),
          color: scheme.primary.withOpacity(0.85),
          disabledColor: scheme.primary.withOpacity(0.3),
          onPressed: () => _handleButtonPress(context),
          child: TextWidget(
            title,
            TextType.titleMedium,
            color: scheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// 🚀 Handles either navigation via GoRouter or a fallback callback
  void _handleButtonPress(BuildContext context) {
    if (onPressedCallback != null) {
      onPressedCallback!();
      return;
    }

    if (routeName?.isNotEmpty ?? false) {
      context.goTo(
        routeName!,
        pathParameters: pathParameters ?? const {},
        queryParameters: queryParameters ?? const {},
      );
    } else {
      debugPrint('⚠️ [CustomButtonForGoRouter] No route or callback provided');
    }
  }

  //
}
