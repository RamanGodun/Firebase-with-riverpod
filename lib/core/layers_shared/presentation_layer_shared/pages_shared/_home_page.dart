import 'package:firebase_with_riverpod/core/modules_shared/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/modules_shared/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/modules_shared/theme/core/constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/modules_shared/navigation/routes_names.dart';
import 'package:firebase_with_riverpod/core/layers_shared/presentation_layer_shared/widgets_shared/custom_app_bar.dart';
import '../../../modules_shared/localization/widgets/text_widget.dart';

/// 🏠 [HomePage] — the main landing screen after login.
/// Displays a toggle for theme switching and navigates to profile/settings.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.pages_home,
        actionWidgets: [
          /// 👤 Navigate to profile
          IconButton(
            icon: const Icon(Icons.person_2),
            onPressed: () => context.pushToNamed(RoutesNames.profile),
          ).withPaddingRight(AppSpacing.xxxm),
        ],
      ),

      body: Center(
        child: const TextWidget(
          LocaleKeys.pages_home_message,
          TextType.bodyLarge,
          isTextOnFewStrings: true,
        ).withPaddingHorizontal(AppSpacing.l),
      ),
    );
  }
}
