import 'package:firebase_with_riverpod/core/modules_shared/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/modules_shared/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/modules_shared/theme/ui_constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/layers_shared/presentation_layer_shared/widgets_shared/app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../modules_shared/localization/widgets/text_widget.dart';
import '../../../modules_shared/navigation/app_routes/app_routes.dart';

/// 🏠 [HomePage] — the main landing screen after login.
/// Displays a toggle for theme switching and navigates to profile/settings.

class HomePage extends ConsumerWidget {
  //----------------------------------
  const HomePage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    return Scaffold(
      appBar: const CustomAppBar(
        title: LocaleKeys.pages_home,
        actionWidgets: [_GoToProfilePageButton()],
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

  //
}

////

////

/// 👤 [_GoToProfilePageButton] — Navigates to profile page when pressed

class _GoToProfilePageButton extends StatelessWidget {
  ///------------------------------------------------
  const _GoToProfilePageButton();

  @override
  Widget build(BuildContext context) {
    //
    return IconButton(
      icon: const Icon(Icons.person_2),
      onPressed: () => context.pushToNamed(RoutesNames.profile),
    ).withPaddingRight(AppSpacing.l);
  }

  //
}
