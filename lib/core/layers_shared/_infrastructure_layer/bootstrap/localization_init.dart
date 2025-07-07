import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import '../../../foundation/localization/app_localizer.dart';

/// 🌍 [ILocalizationStack] — Abstraction for localization initialization logic.
/// ✅ Used to decouple localization startup logic and enable mocking in tests.

abstract interface class ILocalizationStack {
  ///-------------------------------------
  //
  /// Initializes localization services (e.g., EasyLocalization, custom localizer)
  Future<void> init();
  //
}

////

////

/// 🌍 [DefaultLocalizationStack] — Implementation of [ILocalizationStack].
/// ✅ Initializes localization engine (EasyLocalization) and sets up [AppLocalizer] resolver.

final class DefaultLocalizationStack implements ILocalizationStack {
  ///----------------------------------------------------
  const DefaultLocalizationStack();

  @override
  Future<void> init() async {
    //
    // Ensures EasyLocalization is initialized before runApp.
    await EasyLocalization.ensureInitialized();

    // Sets up the global localization resolver for the app.
    AppLocalizer.init(resolver: (key) => key.tr());
    // AppLocalizer.initWithFallback(); // Uncomment for projects without translations.

    debugPrint('🌍 EasyLocalization initialized!');
  }

  //
}
