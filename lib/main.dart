import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_config/bootstrap/bootstrap.dart';
import 'core/app_config/bootstrap/di_container.dart';
import 'core/shared_modules/localization/localization_config.dart';
import 'core/shared_modules/logging/riverpod_observer.dart';
import 'core/shared_modules/navigation/router_provider.dart';
import 'core/shared_modules/theme/app_theme.dart';
import 'core/shared_modules/theme/theme_provider.dart';

Future<void> main() async {
  ///
  // 🔧 Perform all essential setup: Firebase, .env, local storage, etc.
  await bootstrap();
  await AppBootstrap.initialize();

  // 🚀 Start the app within Riverpod's ProviderScope and custom logger
  runApp(
    ProviderScope(
      overrides: diContainer,
      observers: [Logger()],
      child: AppLocalization.wrap(const RootWidget()),
    ),
  );
}

/// 🌳 [RootWidget] defines the top-level widget that manages global theming and routing
class RootWidget extends ConsumerWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'FB with Riverpod',
      debugShowCheckedModeBanner: false,

      /// 📍 Dynamic routing with help of GoRouter
      routerConfig: router,

      /// 🎨 Current theme mode
      themeMode: themeMode,
      theme: AppThemes.getLightTheme(),
      darkTheme: AppThemes.getDarkTheme(),

      /// 🌐  Localization
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}

/*
flutter pub run build_runner build --delete-conflicting-outputs
 */
