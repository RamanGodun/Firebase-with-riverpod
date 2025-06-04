import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_context_x.dart';
import '../failures_for_domain_and_presentation/failure_ui_model.dart';
import '../failures_for_domain_and_presentation/to_ui_failures_x.dart';
import '../utils/consumable.dart';
import '../../../utils/typedef.dart';

/// 📦 [ResultAwareHandler] — reusable handler for results
final class ResultAwareHandler<T> {
  Consumable<FailureUIModel>? failureUIModel;

  Future<void> handleResult(
    ResultFuture<T> result,
    void Function(T) onSuccess,
  ) async {
    final value = await result;
    value.fold((f) => failureUIModel = f.toUIModel().asConsumable(), onSuccess);
  }
}
