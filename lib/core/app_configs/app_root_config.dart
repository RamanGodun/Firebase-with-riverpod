import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../modules_shared/navigation/core/go_router.dart';
import '../modules_shared/theme/theme_utils/theme_mode_adapter.dart';
import '../modules_shared/theme/theme_provider/theme_provider.dart';
import '../modules_shared/localization/localization_config.dart';
import '../modules_shared/theme/core/_theme_config.dart';

/// 🧩 [AppRootConfig] — Immutable object holding all global config required by [MaterialApp].
/// ✅ Clean separation of logic & widget layer, with convenient factory for Riverpod or Bloc integration.

@immutable
final class AppRootConfig {
  ///----------------------

  final LocalizationConfig localization;
  final AppThemesScheme theme;
  final GoRouter router;

  const AppRootConfig({
    required this.localization,
    required this.theme,
    required this.router,
  });
  //

  /// 🏭 Factory method that builds [AppRootConfig] from Riverpod/Bloc + Flutter context.
  factory AppRootConfig.from({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    ///
    final localization = LocalizationConfig.fromContext(context);

    ///
    final theme = AppThemeBuilder.from(
      ThemeModeAdapter(ref.watch(themeModeProvider)), //  ? when using Riverpod
    );
    // final theme = AppThemeBuilder.from(themeState); // ? when using BLoC

    ///
    final router = ref.watch(goRouter); // ? when use Riverpod
    //  final router = AppRouterConfig.router; // ? when using BLoC

    return AppRootConfig(
      localization: localization,
      theme: theme,
      router: router,
    );
  }

  //
}
