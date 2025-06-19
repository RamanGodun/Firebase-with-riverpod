import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../modules_shared/navigation/core/go_router.dart';
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
    //
    final localization = LocalizationConfig.fromContext(context);

    ///
    final theme = AppThemeBuilder.fromMode(ref.watch(themeModeProvider));
    /*
    ? when using BLoC as state manager, uncomment next:
    final theme = ThemeConfig.fromBloc(themeState);

    ? when use Riverpod state manager, uncomment next:
    final theme = ThemeConfig.from(ref.watch(themeModeProvider));
 */

    ///
    final router = ref.watch(goRouter);
    /*
    ? when use Riverpod state manager, uncomment next:
    final router = ref.watch(goRouter);
    
    ? when use BLoC state manager, uncomment next:
    final router = AppRouterConfig.router;
 */

    return AppRootConfig(
      localization: localization,
      theme: theme,
      router: router,
    );
  }

  //
}
