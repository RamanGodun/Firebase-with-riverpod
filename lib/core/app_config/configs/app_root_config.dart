import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'localization_config.dart';
import 'theme_config.dart';

/// 🧩 [AppRootConfig] — Immutable object holding all global config required by [MaterialApp].
/// This ensures a clean separation of concerns between logic and widget layer.
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
}
