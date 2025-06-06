// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
// import '../../../core/utils/typedef.dart';

// /// 🛠 [ErrorHandlerUtils] — shared helper to handle AsyncNotifiers with `FailureUIModel`
// /// ✅ Extracts failure, calls showError, and resets state if needed
// /// ─────────────────────────────────────────────────────────────────────
// final class ErrorHandlerUtils {
//   const ErrorHandlerUtils._();

//   ///
//   static Future<void>
//   executeAndHandleFailure<TNotifier extends AutoDisposeAsyncNotifier<T>>({
//     required WidgetRef ref,
//     required Future<void> Function(TNotifier notifier) run,
//     required AutoDisposeAsyncNotifierProvider<TNotifier, T> provider,
//     required ErrorDispatcher onError,
//   }) async {
//     final notifier = ref.read(provider.notifier);
//     await run(notifier);

//     final failure = ref
//         .read(provider)
//         .maybeWhen(error: (e, _) => e, orElse: () => null);

//     if (failure case final FailureUIModel model) {
//       onError(model);
//       notifier.reset();
//     }
//   }
// }
