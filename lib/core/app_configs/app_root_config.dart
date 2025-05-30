import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../shared_modules/theme/provider_and_toggle_widget/theme_provider.dart';
import 'localization_config.dart';
import 'router_config.dart';
import 'theme_config.dart';

/// 🧩 [AppRootConfig] — Immutable object holding all global config required by [MaterialApp].
/// ✅ Clean separation of logic & widget layer, with convenient factory for Riverpod integration.
@immutable
final class AppRootConfig {
  final AppThemeConfig theme;
  final LocalizationConfig localization;
  final GoRouter router;

  const AppRootConfig({
    required this.theme,
    required this.localization,
    required this.router,
  });

  /// 🏭 Factory method that builds [AppRootConfig] from Riverpod + Flutter context.
  factory AppRootConfig.from({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    final theme = ThemeConfig.from(ref.watch(themeModeProvider));
    final localization = LocalizationConfig.fromContext(context);
    final router = AppRouterConfig.use(ref);

    return AppRootConfig(
      theme: theme,
      localization: localization,
      router: router,
    );
  }

  //
}
