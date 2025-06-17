import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show ProviderListenable;

import 'di_container.dart' show globalContainer;

///🔌 [ContextDI] — Provides access to global DI container via context
///✅ Replaces `di<T>()` from legacy GetIt usage
///────────────────────────────────────────────
extension ContextDI on BuildContext {
  T readDI<T>(ProviderListenable<T> provider) {
    return globalContainer.read(provider);
  }
}
